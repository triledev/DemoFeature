//
//  DemoFeatureAPIEndToEndTests.swift
//  DemoFeatureAPIEndToEndTests
//
//  Created by Tri Le on 8/18/22.
//

import XCTest
import DemoFeature

class DemoFeatureAPIEndToEndTests: XCTestCase {

    func demo() {
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, directory: nil)
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        let url = URL(string: "http://any-url")!
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: 30)
        URLCache.shared =  cache
    }

    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        let count = 5
        let receivedResult = getFeedResult(count: count)

        switch receivedResult {
        case let .success(items)?:
            XCTAssertEqual(items.count, count, "Expected \(count) items in the test account feed")

        case let .failure(error)?:
            XCTFail("Expected successful feed result, got \(error) error instead")

        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }

    // MARK: - Helpers

    private func makeTestServerURL(count limit: Int) -> URL {
        let accessKey = "bc6aff46b7ed7e0b2e29c421ffc9fcfd"
        let limit = String(limit)
        let countries = "us"
        let languages = "en"
        let baseURL = "mediastack.com"
        let testServerURL = URL(string: "http://api.\(baseURL)/v1/news?access_key=\(accessKey)&countries=\(countries)&languages=\(languages)&limit=\(limit)")!
        return testServerURL
    }

    private func getFeedResult(count limit: Int, file: StaticString = #filePath, line: UInt = #line) -> LoadFeedResult? {
        let testServerURL = makeTestServerURL(count: limit)
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteFeedLoader(url: testServerURL, client: client)

        trackForMemoryLeak(client, file: file, line: line)
        trackForMemoryLeak(loader, file: file, line: line)

        let exp = expectation(description: "Wait for load completion")

        var receivedResult: LoadFeedResult?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)

        return receivedResult
    }
}
