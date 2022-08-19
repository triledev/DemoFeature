//
//  DemoFeatureAPIEndToEndTests.swift
//  DemoFeatureAPIEndToEndTests
//
//  Created by Tri Le on 8/18/22.
//

import XCTest
import DemoFeature

class DemoFeatureAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        let testServerURL = URL(string: "http://api.mediastack.com/v1/news?access_key=bc6aff46b7ed7e0b2e29c421ffc9fcfd&countries=us&languages=en&limit=8")!
        let client = URLSessionHTTPClient()
        let loader = RemoteFeedLoader(url: testServerURL, client: client)

        let exp = expectation(description: "Wait for load completion")

        var receivedResult: LoadFeedResult?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)

        switch receivedResult {
        case let .success(items)?:
            XCTAssertEqual(items.count, 8)

        case let .failure(error)?:
            XCTFail("Expected successful feed result, got '\(error)' error instead")

        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }
}
