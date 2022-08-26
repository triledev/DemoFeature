//
//  RemoteFeedLoader.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connetivity
        case invalidData
    }

    public typealias Result = LoadFeedResult

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case let .success(data, response):
                do {
                    let items = try FeedItemsMapper.map(data, from: response)
                    completion(.success(items.toModels()))
                } catch {
                    completion(.failure(error))
                }
            case .failure:
                completion(.failure(Error.connetivity))
            }
        }
    }
}

private extension Array where Element == RemoteFeedItem {
    func toModels() -> [FeedItem] {
        return map { FeedItem(author: $0.author, title: $0.title, description: $0.description, url: $0.url, source: $0.source, imageURL: $0.image, category: $0.category, language: $0.language, country: $0.country, publishedAt: $0.published_at) }
    }
}
