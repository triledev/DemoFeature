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
    internal let imageURL: URL?
    internal let category: String?
    internal let language: String?
    internal let country: String?
    internal let publishedAt: String?

    private enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case source = "source"
        case imageURL = "image"
        case category = "category"
        case language = "language"
        case country = "country"
        case publishedAt = "published_at"
    }
}

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let pagination: Pagination
        let items: [RemoteFeedItem]

        private enum CodingKeys: String, CodingKey {
            case pagination = "pagination"
            case items = "data"
        }
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
