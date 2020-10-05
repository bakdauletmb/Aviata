import Foundation

class ParseManager {
    
    static let shared = ParseManager()
    
    let networkManager: NetworkManager = Router(parser: DefaultParserImpl())
    
    private init() {}
    
    func multipartFormData<T: Decodable>(url: String, parameters: Parameters? = nil,
                                         success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.multipartFormData(url: url, parameters: parameters, token: UserManager.getCurrentToken())
        let dispatch = DispatchQueue.global(qos: .utility)
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Results<T>) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let errorMessage):
                        error(errorMessage)
                    case .success(let value):
                        success(value)
                    }
                }
            }
        }
    }
    
    func postRequest<T: Decodable>(url: String, parameters: Parameters? = nil, token: String? = UserManager.getCurrentToken(), success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.post(url: url, parameters: parameters, token: token)
        self.networkManager.request(endpoint) { (result: Results<T>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value)
                }
            }
        }
    }
    
    func getRequest<T: Decodable>(url: String, parameters: Parameters? = nil, token: String? = UserManager.getCurrentToken(),
                                  success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.get(url: url, parameters: parameters, token: token)
        
        self.networkManager.request(endpoint) { (result: Results<T>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value)
                }
            }
        }
    }
    
    func deleteRequest<T: Decodable>(url: String, parameters: Parameters? = nil, url_parameters: Parameters? = nil,
                                   success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.delete(url: url, parameters: nil, url_parameters: url_parameters, token: nil)
        self.networkManager.request(endpoint) { (result: Results<T>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value)
                }
            }
        }
    }
   
}
