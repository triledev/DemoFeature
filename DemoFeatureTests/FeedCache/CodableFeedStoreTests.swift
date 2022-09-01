//
//  CodableFeedStoreTests.swift
//  DemoFeatureTests
//
//  Created by Tri Le on 8/31/22.
//

import XCTest
import DemoFeature

class CodableFeedStore {
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.empty)
    }

    func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        completion(nil)
    }
}

class CodableFeedStoreTests: XCTestCase {

    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = CodableFeedStore()
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
        let sut = CodableFeedStore()
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

//    func test_retrieveAfterInsertingToEmptyCache_deliversInsertedValues() {
//        let sut = CodableFeedStore()
//        let feed = uniqueItemFeed().local
//        let timestamp = Date()
//        let exp = expectation(description: "Wait for cache retrieval")
//
//        sut.insert(feed, timestamp: timestamp) { insertError in
//            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")
//
//            sut.retrieve { retrieveResult in
//                switch retrieveResult {
//                case let .found(retrievedFeed, retrievedTimestamp):
//                    XCTAssertEqual(retrievedFeed, feed)
//                    XCTAssertEqual(retrievedTimestamp, timestamp)
//                default:
//                    XCTFail("Expected found result with feed \(feed) and timestamp \(timestamp), got \(retrieveResult) instead")
//                }
//                exp.fulfill()
//            }
//        }
//
//        wait(for: [exp], timeout: 1.0)
//    }
}
