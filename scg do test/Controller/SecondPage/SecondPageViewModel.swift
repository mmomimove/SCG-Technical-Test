//
//  SecondPageViewModel.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation

protocol SecondPageViewModelDelegate {
    
}

final class SecondPageViewModel {
    
    // MARK: - Parameter
    var delegate: SecondPageViewModelDelegate?
    var data: NewsModel? = nil
    
    // MARK: - UseCase

    
    init(delegate: SecondPageViewModelDelegate,
         data: NewsModel?) {
        self.delegate = delegate
        self.data = data
    }
    
    // MARK: - Function
    
}
