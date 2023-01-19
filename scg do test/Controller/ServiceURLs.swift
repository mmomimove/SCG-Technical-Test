//
//  ServiceURLs.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation

class ServiceURLs {
    
    static var BASE_API: String {
        return "https://newsapi.org/v2/everything"
    }
    
    static var NEWS_DATA: String {
        return BASE_API + "?q={q}&apiKey={API key}"
    }
    
}
