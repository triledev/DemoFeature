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
                managedCache.feed = NSOrderedSet(array: feed.map { local in
                    let managed = ManagedFeedItem(context: context)
                    managed.author = local.author
                    managed.title = local.title
                    managed.itemDescription = local.description
                    managed.url = local.url
                    managed.source = local.source
                    managed.image = local.imageURL
                    managed.category = local.category
                    managed.language = local.language
                    managed.country = local.country
                    managed.publishedAt = local.publishedAt
                    return managed
                })

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
                let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
                request.returnsObjectsAsFaults = false
                if let cache = try context.fetch(request).first {
                    completion(.found(
                        feed: cache.feed
                                .compactMap { ($0 as? ManagedFeedItem)}
                                .map {
                                    LocalFeedItem(author: $0.author, title: $0.title, description: $0.description, url: $0.url, source: $0.source, imageURL: $0.imageURL, category: $0.category, language: $0.language, country: $0.country, publishedAt: $0.publishedAt)
                                },
                        timestamp: cache.timestamp))
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
}

@objc(ManagedFeedItem)
private class ManagedFeedItem: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var title: String?
    @NSManaged var itemDescription: String?
    @NSManaged var url: URL?
    @NSManaged var source: String?
    @NSManaged var image: URL?
    @NSManaged var category: String?
    @NSManaged var language: String?
    @NSManaged var country: String?
    @NSManaged var publishedAt: String?
    @NSManaged var cache: ManagedCache
}
