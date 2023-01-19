//
//  Service.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
    
    static let shared: Service = Service()
    
    let apiKey = "87e4a2c2ec4647b1afe5ee4675a387ef"
    
    func searchResult(searchText: String,
                      completionHandler: @escaping ([NewsModel]) -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        var url = ServiceURLs.NEWS_DATA
        url = url.replacingOccurrences(of: "{q}", with: "\(searchText)")
        url = url.replacingOccurrences(of: "{API key}", with: "\(self.apiKey)")
        
        AF.request(url).responseJSON { responseData in
            DispatchQueue.main.async {
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)["articles"]
                    let data = json.arrayValue.map({ NewsModel.init(json: $0) })
                    completionHandler(data)
                case .failure(let error):
                    errorHandler(error)
                }
            }
        }
    }
    
}
