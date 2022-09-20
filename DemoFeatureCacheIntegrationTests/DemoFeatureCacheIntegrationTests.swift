//
//  DemoFeatureCacheIntegrationTests.swift
//  DemoFeatureCacheIntegrationTests
//
//  Created by Tri Le on 9/20/22.
//

import XCTest
import DemoFeature

class DemoFeatureCacheIntegrationTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupEmptyStoreState()
    }

    override func tearDown() {
        super.tearDown()

        undoStoreSideEffects()
    }

    func test_load_deliversNoItemsOnEmptyCache() {
        let sut = makeSUT()

        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(itemFeed):
                XCTAssertEqual(itemFeed, [], "Expected empty feed")
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(error) instead")
            }

            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    func test_load_deliversItemsSavedOnASeparateInstance() {
        let sutToPerformSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let feed = uniqueItemFeed().models

        let saveExp = expectation(description: "Wait for save completion")
        sutToPerformSave.save(feed) { saveError in
            XCTAssertNil(saveError, "Expected to save successfully")
            saveExp.fulfill()
        }
        wait(for: [saveExp], timeout: 1.0)

        let loadExp = expectation(description: "Wait for load completion")
        sutToPerformLoad.load { loadResult in
            switch loadResult {
            case let .success(itemFeed):
                XCTAssertEqual(itemFeed, feed)
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(error) instead")
            }

            loadExp.fulfill()
        }
        wait(for: [loadExp], timeout: 1.0)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LocalFeedLoader {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = testSpecificStoreURL()
        let store = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        let sut = LocalFeedLoader(store: store, currentDate: Date.init)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }

    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }

    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }

    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }

    /*
     .userDomainMask work for macOS framework target.
     The cache directory permission is different in the iOS simulator
     (you can delete the directory on the simulator, but not on the macOS target!)
     */
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    /*
     .systemDomainMask work for iOS app target.
     */
    private func noDeletePermissionURL() -> URL {
      return FileManager.default.urls(for: .cachesDirectory, in: .systemDomainMask).first!
    }
}
