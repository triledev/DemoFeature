//
//  CacheFeedUseCaseTests.swift
//  DemoFeatureTests
//
//  Created by Tri Le on 8/22/22.
//

import XCTest
import DemoFeature

class CacheFeedUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedMessages, [])
    }

    func test_save_requestsCacheDeletion() {
        let (sut, store) = makeSUT()

        sut.save(uniqueItems().models) { _ in }

        XCTAssertEqual(store.receivedMessages, [.deleteCacheFeed])
    }

    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()

        sut.save(uniqueItems().models) { _ in }
        store.completeDeletion(with: deletionError)

        XCTAssertEqual(store.receivedMessages, [.deleteCacheFeed])
    }

    func test_save_requestNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let items = uniqueItems()
        let (sut, store) = makeSUT(currentDate: { timestamp } )

        sut.save(items.models) { _ in }
        store.completeDeletionSuccessfully()

        XCTAssertEqual(store.receivedMessages, [.deleteCacheFeed, .insert(items.local, timestamp)])
    }

    func test_save_failsOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()

        expect(sut, toCompleteWithError: deletionError, when: {
            store.completeDeletion(with: deletionError)
        })
    }

    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSUT()
        let insertionError = anyNSError()

        expect(sut, toCompleteWithError: insertionError, when: {
            store.completeDeletionSuccessfully()
            store.completeInsertion(with: insertionError)
        })
    }

    func test_save_succeedsOnSuccessfulCacheInsertion() {
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWithError: nil, when: {
            store.completeDeletionSuccessfully()
            store.completeInsertionSuccessfully()
        })
    }

    func test_save_doesNotDeliverDeletionErrorAfterSUTInstanceHasBeenDeallocated() {
        let store = FeedStoreSpy()
        var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)

        var receivedResults = [LocalFeedLoader.SaveResult]()
        sut?.save(uniqueItems().models) { receivedResults.append($0) }

        sut = nil
        store.completeDeletion(with: anyNSError())

        XCTAssertTrue(receivedResults.isEmpty)
    }

    func test_save_doesNotDeliverInsertionErrorAfterSUTInstanceHasBeenDeallocated() {
        let store = FeedStoreSpy()
        var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)

        var receivedResults = [LocalFeedLoader.SaveResult]()
        sut?.save(uniqueItems().models) { receivedResults.append($0) }

        store.completeDeletionSuccessfully()
        sut = nil
        store.completeInsertion(with: anyNSError())

        XCTAssertTrue(receivedResults.isEmpty)
    }

    // MARK: - Helpers

    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeak(store, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return (sut, store)
    }

    private func expect(_ sut: LocalFeedLoader, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for save completion")
        var receivedError: Error?
        sut.save(uniqueItems().models) { error in
            receivedError = error
            exp.fulfill()
        }

        action()
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError as NSError?, expectedError, file: file, line: line)

    }

    private class FeedStoreSpy: FeedStore {
        typealias DeletionCompletion = (Error?) -> Void
        typealias InsertionCompletion = (Error?) -> Void

        enum ReceivedMessage: Equatable {
            case deleteCacheFeed
            case insert([LocalFeedItem], Date)
        }

        private(set) var receivedMessages = [ReceivedMessage]()

        private var deletionCompletions = [DeletionCompletion]()
        private var insertionCompletions = [InsertionCompletion]()

        func deleteCacheFeed(completion: @escaping DeletionCompletion) {
            deletionCompletions.append(completion)
            receivedMessages.append(.deleteCacheFeed)
        }

        func completeDeletion(with error: Error, at index: Int = 0) {
            deletionCompletions[index](error)
        }

        func completeDeletionSuccessfully(at index: Int = 0) {
            deletionCompletions[index](nil)
        }

        func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {
            insertionCompletions.append(completion)
            receivedMessages.append(.insert(items, timestamp))
        }

        func completeInsertion(with error: Error, at index: Int = 0) {
            insertionCompletions[index](error)
        }

        func completeInsertionSuccessfully(at index: Int = 0) {
            insertionCompletions[index](nil)
        }
    }

    private func uniqueItem() -> FeedItem {
        return FeedItem(author: "John Doe", title: "any", description: "any", url: anyURL(), source: "any", imageURL: anyURL(), category: "any", language: "en", country: "us", publishedAt: "any")
    }

    private func uniqueItems() -> (models: [FeedItem], local: [LocalFeedItem]) {
        let models = [uniqueItem(), uniqueItem()]
        let local = models.map { LocalFeedItem(author: $0.author, title: $0.title, description: $0.description, url: $0.url, source: $0.source, imageURL: $0.imageURL, category: $0.category, language: $0.language, country: $0.country, publishedAt: $0.publishedAt) }
        return (models, local)
    }
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }

    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
