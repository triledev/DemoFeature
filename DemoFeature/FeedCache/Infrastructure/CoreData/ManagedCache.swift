//
//  ManagedCache.swift
//  DemoFeature
//
//  Created by Tri Le on 9/9/22.
//

import CoreData

@objc(ManageCache)
internal class ManagedCache: NSManagedObject {
    @NSManaged internal var timestamp: Date
    @NSManaged internal var feed: NSOrderedSet
}

@objc(ManagedFeedImage)
internal class ManageFeedItem: NSManagedObject {
    @NSManaged internal var author: String?
    @NSManaged internal var title: String?
    @NSManaged internal var itemDescription: String?
    @NSManaged internal var url: URL?
    @NSManaged internal var source: String?
    @NSManaged internal var image: URL?
    @NSManaged internal var category: String?
    @NSManaged internal var language: String?
    @NSManaged internal var country: String?
    @NSManaged internal var publishedAt: String?
    @NSManaged internal var cache: ManagedCache
}
