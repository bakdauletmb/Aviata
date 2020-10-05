

import Foundation

protocol DefaultViewModelOutput {
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
}
enum URLType {
    case everything
    case topHeadlines
}

class MainPageViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var articles : Observable<[ArticleModel]> = Observable([])
    
    func getPost(with parameters : Parameters, urlType : URLType, fromAutoUpdate : Bool = false) {
        self.loading.value = true
        ParseManager.shared.getRequest(url: urlType == .everything ? AppConstants.API.everything : AppConstants.API.topHeadlines, parameters: parameters) { (result : MainPageModel) in
            self.loading.value = false
            if fromAutoUpdate {
                //check if local posts and post in API are the same
                if let first = result.articles.first{
                    if let second = self.articles.value.first {
                        if type(of: first)  != type(of: second) {
                            self.articles.value = result.articles
                        }
                    }
                }
            }
            else {
                self.articles.value.append(contentsOf: result.articles)
            }
        } error: { (error) in
            self.loading.value = false
            self.error.value = error
        }

    }
    
}
