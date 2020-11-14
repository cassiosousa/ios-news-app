//
//  BrowseNewsViewModel.swift
//  NewsAppTests
//
//  Created by Cassio Sousa on 10/10/20.
//  Copyright © 2020 Cassio Sousa. All rights reserved.
//

import XCTest

class BrowseNewsViewModel: XCTestCase {
    
    private let sut = BrowseNewsListViewModel()
    
    override func setUp() {
        
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
    }

    /**
            It makes a test to test numbersOfItemsInSection
     */
    func testNumbersOfItemsInSection() throws {
        XCTAssertEqual(4, sut.numbersOfItemsInSection)
    }
    
    /**
        It makes a test to test flagAt
     */
    func testFlagAt() throws {
        if let result = sut.flagAt(index: 0) {
            XCTAssertEqual("brazil", result);
        }else{
            XCTFail("The flag brazil does not exist.");
        }
    }
    
    /**
        It makes a test to test flagAt out of range
     */
    func testFlagAtOutOfRange() throws {
        XCTAssertEqual(.none, sut.flagAt(index: 5));
        XCTAssertEqual(.none, sut.flagAt(index: -1));
    }
    
    /**
        It makes a test to test flagKey
     */
    func testFlagKey() throws {
        if let result = sut.flagKey(index: 1) {
            XCTAssertEqual("us", result);
        }else{
            XCTFail("The flag US does not exist.");
        }
    }
    
    /**
        It makes a test to test flagKey out of range
     */
    func testFlagKeyOutOfRange() throws {
        XCTAssertEqual(.none, sut.flagKey(index: 5));
        XCTAssertEqual(.none, sut.flagKey(index: -1));
    }
    
    /**
        It makes a test to test firstKey
     */
    func testFirstKey() throws {
        XCTAssertEqual("br",  sut.firstKeyFlag());
    }
    
    /**
        It makes a test to test firstValueFlag
     */
    func testFirstVlaueFlag() throws {
        XCTAssertEqual("brazil",  sut.firstValueFlag());
    }
    
    /**
        It makes a test to test flagAt
     */
    func testFagAtNotIndex() throws {
        XCTAssertEqual(.none, sut.flagAt(index: 10))
    }

}
