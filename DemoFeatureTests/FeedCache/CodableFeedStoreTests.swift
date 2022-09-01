//
//  CodableFeedStoreTests.swift
//  DemoFeatureTests
//
//  Created by Tri Le on 8/31/22.
//

import XCTest
import DemoFeature

class CodableFeedStore {
    private struct Cache: Codable {
        let feed: [CodableFeedItem]
        let timestamp: Date

        var localFeed: [LocalFeedItem] {
            return feed.map { $0.local }
        }
    }

    private struct CodableFeedItem: Codable {
        private let author: String?
        private let title: String?
        private let description: String?
        private let url: URL?
        private let source: String?
        private let imageURL: URL?
        private let category: String?
        private let language: String?
        private let country: String?
        private let publishedAt: String?

        init(_ item: LocalFeedItem) {
            author = item.author
            title = item.title
            description = item.description
            url = item.url
            source = item.source
            imageURL = item.imageURL
            category = item.category
            language = item.language
            country = item.country
            publishedAt = item.publishedAt
        }

        var local: LocalFeedItem {
            return LocalFeedItem(author: author, title: title, description: description, url: url, source: source, imageURL: imageURL, category: category, language: language, country: country, publishedAt: publishedAt)
        }
    }

    private let storeURL: URL

    init(storeURL: URL) {
        self.storeURL = storeURL
    }

    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }

        let decoder = JSONDecoder()
        let cache = try! decoder.decode(Cache.self, from: data)
        completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
    }

    func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        let encoder = JSONEncoder()
        let cache = Cache(feed: feed.map(CodableFeedItem.init), timestamp: timestamp)
        let encoded = try! encoder.encode(cache)
        try! encoded.write(to: storeURL)
        completion(nil)
    }
}

class CodableFeedStoreTests: XCTestCase {

    override func setUp() {
        super.setUp()

        try? FileManager.default.removeItem(at: storeURL())
    }

    override func tearDown() {
        super.tearDown()

        try? FileManager.default.removeItem(at: storeURL())
    }

    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.retrieve { result in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result, got \(result) instead")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.retrieve { firstResult in
            sut.retrieve { secondResult in
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                default:
                    XCTFail("Expected retrieving twice from empty cache to deliver same empty result, got \(firstResult) and \(secondResult) instead")
                }
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_retrieveAfterInsertingToEmptyCache_deliversInsertedValues() {
        let sut = makeSUT()
        let feed = uniqueItemFeed().local
        let timestamp = Date()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.insert(feed, timestamp: timestamp) { insertionError in
            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")

            sut.retrieve { retrieveResult in
                switch retrieveResult {
                case let .found(retrievedFeed, retrievedTimestamp):
                    XCTAssertEqual(retrievedFeed, feed)
                    XCTAssertEqual(retrievedTimestamp, timestamp)
                default:
                    XCTFail("Expected found result with feed \(feed) and timestamp \(timestamp), got \(retrieveResult) instead")
                }

                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 1.0)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> CodableFeedStore {
        let sut = CodableFeedStore(storeURL: storeURL())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func storeURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("item-feed.store")
    }
}
