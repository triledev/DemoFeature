//
//  TestData.swift
//  DemoFeature
//
//  Created by Tri Le on 8/17/22.
//

import Foundation

struct TestData {
    static let story: FeedItem = {
        let url = Bundle.main.url(forResource: "Story", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try! decoder.decode(FeedItem.self, from: data)
    }()
}
