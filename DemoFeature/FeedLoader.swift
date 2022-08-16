//
//  FeedLoader.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}
protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
