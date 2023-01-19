//
//  scg_do_testTests.swift
//  scg do testTests
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import XCTest
@testable import scg_do_test

final class scg_do_testTests: XCTestCase {

    func testUseCase() {
        let mockData = "Apple"
        NewsDataUseCase.init().execute(.init(searchText: mockData,
                                             completion: { _ in
            XCTAssert(true)
        }, error: { _ in
            XCTAssert(false)
        }))
    }

}
