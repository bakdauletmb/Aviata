//
//  ViewModel.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import Foundation
import RealmSwift

class MainPageModel: Decodable {
    var status: String?
    var totalResults : Int?
    var articles : [ArticleModel]
}
class ArticleModel : Decodable{
    var author : String?
    var source: SourceModel?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
}
class SourceModel : Decodable {
    var name : String?
}

class SavedArticleModel : Object {
    @objc dynamic var linkToArticle = ""
    @objc dynamic var title = ""
}
