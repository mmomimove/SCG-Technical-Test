//
//  NewsDataUC.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation

public struct NewsDataUseCaseParameter {
    
    let searchText: String
    let completion: (([NewsModel]) -> Void)
    let error: ((Error) -> Void)
    
    init(searchText: String,
         completion: @escaping ([NewsModel]) -> Void,
         error: @escaping (Error) -> Void) {
        self.searchText = searchText
        self.completion = completion
        self.error = error
    }
    
}

public class NewsDataUseCase {
    public func execute(_ param: NewsDataUseCaseParameter) {
        Service.shared.searchResult(searchText: param.searchText) { data in
            param.completion(data)
        } errorHandler: { error in
            param.error(error)
        }
    }
}
