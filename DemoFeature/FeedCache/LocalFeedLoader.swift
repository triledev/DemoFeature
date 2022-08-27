//
//  LocalFeedLoader.swift
//  DemoFeature
//
//  Created by Tri Le on 8/26/22.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date

    public typealias SaveResult = Error?
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }

    public func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleteCacheFeed { [weak self] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(items, with: completion)
            }
        }
    }

    public func load() {
        store.retrieve()
    }

    private func cache(_ items: [FeedItem], with completion: @escaping (SaveResult) -> Void) {
        self.store.insert(items.toLocal(), timestamp: currentDate()) { [weak self]  error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedItem {
    func toLocal() -> [LocalFeedItem] {
        return map { LocalFeedItem(author: $0.author, title: $0.title, description: $0.description, url: $0.url, source: $0.source, imageURL: $0.imageURL, category: $0.category, language: $0.language, country: $0.country, publishedAt: $0.publishedAt)}
    }
}
