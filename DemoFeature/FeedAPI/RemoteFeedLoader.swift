//
//  RemoteFeedLoader.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connetivity
        case invalidData
    }

    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(RemoteFeedLoader.map(data, from: response))
            case .failure:
                completion(.failure(.connetivity))
            }
        }
    }

    // MARK: - Helpers

    private static var OK_200 = 200
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Feed.self, from: data) else {
            return .failure(.invalidData)
        }

        return .success(root.data)
    }
}
