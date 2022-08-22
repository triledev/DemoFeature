//
//  CacheFeedUseCaseTests.swift
//  DemoFeatureTests
//
//  Created by Tri Le on 8/22/22.
//

import XCTest
import DemoFeature

class LocalFeedLoader {
    private let store: FeedStore

    init(store: FeedStore) {
        self.store = store
    }

    func save(_ items: [FeedItem]) {
        store.deleteCacheFeed()
    }
}

class FeedStore {
    var deleteCacheFeedCallCount = 0

    func deleteCacheFeed() {
        deleteCacheFeedCallCount += 1
    }
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
    }

    func test_save_requestsCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)

        let items = [uniqueItem(), uniqueItem()]
        sut.save(items)

        XCTAssertEqual(store.deleteCacheFeedCallCount, 1)
    }
    
    // MARK: - Helopers

    private func uniqueItem() -> FeedItem {
        return FeedItem(author: "John Doe", title: "any", description: "any", url: anyURL(), source: "any", imageURL: anyURL(), category: "any", language: "en", country: "us", published: "any")
    }

    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
}
