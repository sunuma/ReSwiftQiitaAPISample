//
//  EndPointTests.swift
//  TekitoReduxSampleTests
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import XCTest
import ReSwift
@testable import TekitoReduxSample

class EndPointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUserArticleEndPoint() {
        
    }
    
    func testGetAllArticleEndPoint() {
        let exp = expectation(description: "GetAllArticleEndPoint Method Test")
        let param = GetArticleEndpointParam(perPage: 20, page: 1)
        let request = GetAllArticleEndPoint(param: param)
        HttpsClient().request(request, success: { result in
            if result is ArticleListModel {
                XCTAssertNotNil(result)
            } else {
                XCTAssert(false)
            }
            exp.fulfill()
        }, failure: { error in
            XCTAssertNotNil(error)
            XCTAssert(false)
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
