import Foundation

public protocol Parser {
    func parse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Results<T>
}

public class DefaultParserImpl: Parser {
    public init() {}
    
    public func parse<T>(data: Data?, response: URLResponse?, error: Error?) -> Results<T> where T : Decodable {
        if let error = error {
            return .failure(error.localizedDescription)
        }
        guard let response = response as? HTTPURLResponse else { return .failure("Response is not in HTTPResponse format") }
        switch response.statusCode {
        case 200...499:
            guard let data = data else { return .failure(NetworkResponse.noData.rawValue) }
            
            
            
               
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("JSON:", json)
                

            } catch {
                print("Error with json:", error.localizedDescription)
            }
            
            return decode(data, response: response)
        case 300...399:
            return .failure(NetworkResponse.redirect.rawValue)
        case 400...499:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...501:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    private func decode<T: Decodable>(_ data: Data, response: HTTPURLResponse) -> Results<T> {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            if response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 404 {
                return .success(result)
            } else {
                if let response = try? decoder.decode(ErrorResponse.self, from: data) {
                    
                    return .failure("\(response.message)")
                }
                return .failure("error")
            }
        } catch {
            
            if let response = try? decoder.decode(ErrorResponse.self, from: data) {
                
                return .failure("\(response)")
            }
            return .failure(error.localizedDescription)
        }
    }
}
