//
//  FeedItemMapper.swift
//  DemoFeature
//
//  Created by Tri Le on 8/26/22.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let author: String?
    internal let title: String?
    internal let description: String?
    internal let url: URL?
    internal let source: String?
    internal let image: URL?
    internal let category: String?
    internal let language: String?
    internal let country: String?
    internal let published_at: String?
}

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let pagination: Pagination
        let items: [RemoteFeedItem]
    }

    private static var OK_200: Int { return 200 }

    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
                  throw RemoteFeedLoader.Error.invalidData
              }

        return root.items
    }
}
