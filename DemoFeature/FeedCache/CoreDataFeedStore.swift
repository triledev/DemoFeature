//
//  CoreDataFeedStore.swift
//  DemoFeature
//
//  Created by Tri Le on 9/9/22.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }

    public func deleteCacheFeed(completion: @escaping DeletionCompletion) {

    }

    public func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {
        let context = self.context
        context.perform {
            do {
                let managedCache = ManagedCache(context: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedItem.items(from: feed, in: context)

                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        let context = self.context
        context.perform {
            do {
                if let cache = try ManagedCache.find(in: context) {
                    completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
                } else {
                    completion(.empty)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}

private extension NSPersistentContainer {
    enum LoadingError: Swift.Error {
        case modelNotFound
        case failedToLoadPersistentStores(Swift.Error)
    }
    
    static func load(modelName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
        guard let model = NSManagedObjectModel.with(name: name, in: bundle) else {
            throw LoadingError.modelNotFound
        }

        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]

        var loadError: Swift.Error?
        container.loadPersistentStores { loadError = $1 }
        try loadError.map { throw LoadingError.failedToLoadPersistentStores($0) }

        return container
    }
}

private extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}

@objc(ManagedCache)
private class ManagedCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var feed: NSOrderedSet

    static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
        let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }

    var localFeed: [LocalFeedItem] {
        return feed.compactMap { ($0 as? ManagedFeedItem)?.local }
    }
}

@objc(ManagedFeedItem)
private class ManagedFeedItem: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var title: String?
    @NSManaged var itemDescription: String?
    @NSManaged var url: URL?
    @NSManaged var source: String?
    @NSManaged var imageURL: URL?
    @NSManaged var category: String?
    @NSManaged var language: String?
    @NSManaged var country: String?
    @NSManaged var publishedAt: String?
    @NSManaged var cache: ManagedCache

    static func items(from localFeed: [LocalFeedItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedFeedItem(context: context)
            managed.author = local.author
            managed.title = local.title
            managed.itemDescription = local.description
            managed.url = local.url
            managed.source = local.source
            managed.imageURL = local.imageURL
            managed.category = local.category
            managed.language = local.language
            managed.country = local.country
            managed.publishedAt = local.publishedAt
            return managed
        })
    }

    var local: LocalFeedItem {
        return LocalFeedItem(author: author, title: title, description: itemDescription, url: url, source: source, imageURL: imageURL, category: category, language: language, country: country, publishedAt: publishedAt)
    }
}
