//
//  CoreDataFeedStore.swift
//  DemoFeature
//
//  Created by Tri Le on 9/9/22.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    public init() {}

    public func deleteCacheFeed(completion: @escaping DeletionCompletion) {

    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }

    public func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {

    }
}
