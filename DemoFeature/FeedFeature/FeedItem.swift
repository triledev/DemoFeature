//
//  FeedItem.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

struct FeedItem {
    let pagination: Pagination
    let data: ItemData
}

struct Pagination {
    let limit: Int
    let offset: Int
    let count: Int
    let total: Int
}

struct ItemData {
    let author: String
    let title: String
    let description: String
    let url: URL
    let source: String
    let image: String
    let category: String
    let language: String
    let country: String
    let published_at: String
}
