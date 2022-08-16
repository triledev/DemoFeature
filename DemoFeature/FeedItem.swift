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
    let limit
    let offset
    let count
    let total
}

struct ItemData {
    let author
    let title
    let description
    let url
    let source
    let image
    let category
    let language
    let country
    let published_at
}

