
import Foundation

class Response<T: Decodable>: Decodable {
    let statusCode: Int
    let message: String
    let result: T?
}

class DefaultResponse: Decodable {
    let statusCode: Int
    let message: String
}

class EmptyResponse: Decodable {
    
}


class PaginationResult<T: Decodable>: Decodable {
    let count: Int
    let pages: Int
    let offset: Int
    let page: Int
    let data: T
}
