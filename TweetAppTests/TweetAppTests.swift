//
//  TweetAppTests.swift
//  TweetAppTests
//
//  Created by 渡辺健輔 on 2023/12/07.
//

import XCTest
@testable import TweetApp

final class TweetAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCheckCharacterLimit() throws {
        let tweetEditViewController = TweetEditViewController()
        var result1 = tweetEditViewController.checkCharacterLimit(userNameTextCount: 0,tweetTextCount: 0)
        XCTAssertTrue(result1)
        var result2 = tweetEditViewController.checkCharacterLimit(userNameTextCount: 10,tweetTextCount: 10)
        XCTAssertTrue(result2)
        var result3 = tweetEditViewController.checkCharacterLimit(userNameTextCount: 10,tweetTextCount: 141)
        XCTAssertTrue(result3)
    }

}
