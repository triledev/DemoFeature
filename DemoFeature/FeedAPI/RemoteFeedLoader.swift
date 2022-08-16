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
                do {
                    if response.statusCode == 200 {
                        let decoded = try JSONDecoder().decode(Feed.self, from: data)
                        completion(.success(decoded.data))
                    } else {
                        completion(.failure(.invalidData))
                    }
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connetivity))
            }
        }
    }
}
