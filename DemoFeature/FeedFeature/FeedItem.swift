//
//  FeedItem.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

public struct FeedItem: Equatable {
    let pagination: Pagination
    let data: [NewsItem]

    public init(
        pagination: Pagination,
        data: [NewsItem]
    ) {
        self.pagination = pagination
        self.data = data
    }
}

public struct Pagination: Equatable {
    let limit: Int
    let offset: Int
    let count: Int
    let total: Int

    public init(
        limit: Int,
        offset: Int,
        count: Int,
        total: Int
    ) {
        self.limit = limit
        self.offset = offset
        self.count = count
        self.total = total
    }
}

public struct NewsItem: Equatable {
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let source: String?
    let image: URL?
    let category: String?
    let language: String?
    let country: String?
    let published_at: String?

    public init(
        author: String?,
        title: String?,
        description: String?,
        url: URL?,
        source: String?,
        image: URL?,
        category: String?,
        language: String?,
        country: String?,
        published_at: String?
    ) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.source = source
        self.image = image
        self.category = category
        self.language = language
        self.country = country
        self.published_at = published_at
    }
}
