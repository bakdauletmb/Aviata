
import Foundation

public enum Results<T: Decodable> {
    case failure(String)
    case success(T)
}

public class GeneralPagination<T: Decodable> : Decodable {
    var message: String
    var result: T
}

public class GeneralResult<T: Decodable> : Decodable {
    let message: String
    let data: T
}

public class PageResult<T: Decodable> : Decodable {
    let page: Int
    let pages: Int
    let count: Int
    let offset: Int
    let data: T
}
