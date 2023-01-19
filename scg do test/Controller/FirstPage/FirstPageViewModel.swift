//
//  FirstPageViewModel.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import Foundation

protocol FirstPageViewModelDelegate {
    func reloadData()
}

final class FirstPageViewModel {
    
    // MARK: - Parameter
    var delegate: FirstPageViewModelDelegate?
    var data: [NewsModel] = []
    var textSearch: String = ""
    
    // MARK: - UseCase
    private lazy var newsDataUC: NewsDataUseCase = .init()
    
    init(delegate: FirstPageViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Function
    func getSearchData(searchText: String) {
        self.newsDataUC.execute(.init(searchText: searchText,
                                      completion: { [weak self] data in
            self?.data = data
            self?.delegate?.reloadData()
        }, error: { error in
            print(error)
        }))
    }
    
}
