//
//  NewsModel.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation
import SwiftyJSON

class NewsModel {
    var source: Source? = nil
    var title: String = ""
    var description: String = ""
    var content: String = ""
    var urlToImage: URL?
    var url: URL?
    var author: String = ""
    var publishedAt: Date?
    
    init(json: JSON) {
        self.source = Source.init(json: json["source"])
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.content = json["content"].stringValue
        self.urlToImage = json["urlToImage"].url
        self.url = json["url"].url
        self.author = json["author"].stringValue
        self.publishedAt = json["publishedAt"].dateValue
    }
    
}

class Source {
    
    var id : String = ""
    var name : String = ""
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
    }
    
}

extension JSON {
    
    public var dateValue: Date? {
        get {
            switch self.type {
            case .string:
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.timeZone = TimeZone(identifier: "UTC")
                
                if self.stringValue.contains("T") {
                    if self.stringValue.contains(".") {
                        if self.stringValue.contains("Z") {
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        } else {
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        }
                    } else {
                        if self.stringValue.contains("Z") {
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                        } else {
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        }
                    }
                } else {
                    if self.stringValue.contains(".") {
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS'Z'"
                    } else {
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
                    }
                }
                
                let date = formatter.date(from: self.stringValue)

                return date
            default:
                return nil
            }
        }
    }
    
}
