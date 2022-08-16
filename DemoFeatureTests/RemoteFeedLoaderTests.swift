//
//  RemoteFeedLoaderTests.swift
//  DemoFeatureTests
//
//  Created by Tri Le on 8/15/22.
//

import XCTest
import DemoFeature

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in }
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: .failure(.connetivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }

    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 404, 416, 500]
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                client.complete(withStatusCode: code, at: index)
            })
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data(_: "invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }

    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: .success([]), when: {
            let testJSON = """
            {
             "pagination":{
                    "limit":100,
                    "offset":0,
                    "count":100,
                    "total":10000
                },
                "data":[]
            }
            """
            let emptyListJSON = Data(_: testJSON.utf8)
            
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }

    // MARK: - Happy Path

    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let item1 = FeedItem(
                author: "Kerry Crowley",
                title: "Baseball comes full circle as SF Giants honor Buster Posey, the newest Little League coach",
                description: "The Giants are holding Buster Posey Day at Oracle Park on Saturday ahead of a game against the St. Louis Cardinals.",
                url: URL(string: "https://www.marinij.com/2022/05/05/baseball-comes-full-circle-as-sf-giants-honor-buster-posey-the-newest-little-league-coach/"),
                source: "marinij",
                image: URL(string: "https://www.marinij.com/wp-content/uploads/2022/05/BNG-L-POSEY-1105-2.jpg?w=1400px&strip=all"),
                category: "general",
                language: "en",
                country: "us",
                published: "2022-05-05T18:45:32+00:00"
            )
        let item1JSON = [
            "author": item1.author,
            "title": item1.title,
            "description": item1.description,
            "url": item1.url?.absoluteString,
            "source": item1.source,
            "image": item1.imageURL?.absoluteString,
            "category": item1.category,
            "language": item1.language,
            "country": item1.country,
            "published_at": item1.published
        ]
        
        let item2 = FeedItem(
                author: "Sammy Approved",
                title: "Happy Cinco De Mayo: Five Fast Facts About The Holiday Linked To African American History",
                description:"There is one part they don't teach you in the history books: How Cinco De Mayo is linked to African American history. Take a look at five fast facts about the holiday and how Africans are tied into it all.",
                url: URL(string: "https://globalgrind.com/5050249/happy-cinco-de-mayo-five-fast-facts-about-the-holiday-linked-to-african-american-history/"),
                source: "globalgrind",
                image: URL(string: "https://globalgrind.com/wp-content/uploads/sites/16/2021/05/1620247208824.jpg?quality=80&strip=all&w=560&crop=0,0,100,320px"),
                category: "general",
                language: "en",
                country: "us",
                published: "2022-05-05T18:43:36+00:00"
            )
        let item2JSON = [
            "author": item2.author,
            "title": item2.title,
            "description": item2.description,
            "url": item2.url?.absoluteString,
            "source": item2.source,
            "image": item2.imageURL?.absoluteString,
            "category": item2.category,
            "language": item2.language,
            "country": item2.country,
            "published_at": item2.published
        ]

        let pagination = Pagination(limit: 25, offset: 0, count: 25, total: 10000)
        let paginationJSON = [
            "limit": pagination.limit.description,
            "offset": pagination.offset.description,
            "count": pagination.count.description,
            "total": pagination.total.description
        ]

//        let itemsJSON = [ "pagination": paginationJSON, "data": [item1JSON, item2JSON] ]
//        _ = Feed(pagination: pagination, data: [item1, item2])

        expect(sut, toCompleteWith: .success([item1, item2]), when: {
//            let json = try! JSONSerialization.data(withJSONObject: itemsJSON)
//            let json = try! JSONSerialization.data(withJSONObject: feedJSON)
            let jsonData = feedJSON.data(using: .utf8)!
            client.complete(withStatusCode: 200, data: jsonData)
        })
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    private func expect(_ sut: RemoteFeedLoader, toCompleteWith result: RemoteFeedLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        var capturedResults = [RemoteFeedLoader.Result]()
        sut.load { capturedResults.append($0) }
        action()
        XCTAssertEqual(capturedResults, [result], file: file, line: line)
    }

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success(data, response))
        }
    }
    
    let feedJSON = """
    {
        "pagination":{
            "limit":25,
            "offset":0,
            "count":25,
            "total":10000
        },
        "data":[
            {
                "author":"Kerry Crowley",
                "title":"Baseball comes full circle as SF Giants honor Buster Posey, the newest Little League coach",
                "description":"The Giants are holding Buster Posey Day at Oracle Park on Saturday ahead of a game against the St. Louis Cardinals.",
                "url":"https://www.marinij.com/2022/05/05/baseball-comes-full-circle-as-sf-giants-honor-buster-posey-the-newest-little-league-coach/",
                "source":"marinij",
                "image":"https://www.marinij.com/wp-content/uploads/2022/05/BNG-L-POSEY-1105-2.jpg?w=1400px&strip=all",
                "category":"general",
                "language":"en",
                "country":"us",
                "published_at":"2022-05-05T18:45:32+00:00"
            },
            {
                "author":"Sammy Approved",
                "title":"Happy Cinco De Mayo: Five Fast Facts About The Holiday Linked To African American History",
                "description":"There is one part they don't teach you in the history books: How Cinco De Mayo is linked to African American history. Take a look at five fast facts about the holiday and how Africans are tied into it all.",
                "url":"https://globalgrind.com/5050249/happy-cinco-de-mayo-five-fast-facts-about-the-holiday-linked-to-african-american-history/",
                "source":"globalgrind",
                "image":"https://globalgrind.com/wp-content/uploads/sites/16/2021/05/1620247208824.jpg?quality=80&strip=all&w=560&crop=0,0,100,320px",
                "category":"general",
                "language":"en",
                "country":"us",
                "published_at":"2022-05-05T18:43:36+00:00"
            }
        ]
    }
    """
}
