//
//  FeedStore.swift
//  DemoFeature
//
//  Created by Tri Le on 8/26/22.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void

    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}

public struct LocalFeedItem: Equatable {
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: URL?
    public let source: String?
    public let imageURL: URL?
    public let category: String?
    public let language: String?
    public let country: String?
    public let publishedAt: String?

    public init(
        author: String?,
        title: String?,
        description: String?,
        url: URL?,
        source: String?,
        imageURL: URL?,
        category: String?,
        language: String?,
        country: String?,
        publishedAt: String?
    ) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.source = source
        self.imageURL = imageURL
        self.category = category
        self.language = language
        self.country = country
        self.publishedAt = publishedAt
    }
}
