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
            let emptyListJSON = Data(_: "{\"pagination\":{},\"data\":[]}".utf8)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }

    // MARK: - Happy Path

    private func newsItems() -> [NewsItem] {
        let newsItems = [
            NewsItem(
                author: "ICT Business",
                title: "\u00ab\u0633\u0644\u0643\u062a\u00bb \u062a\u0648\u0642\u0639 \u0627\u062a\u0641\u0627\u0642\u064a\u0629 \u062a\u0639\u0627\u0648\u0646 \u0645\u0639 \u00ab\u0641\u0631\u064a\u0634 \u0625\u0644\u064a\u0643\u062a\u0631\u064a\u0643\u00bb \u0644\u062a\u0632\u0648\u064a\u062f \u0627\u0644\u0639\u0645\u0644\u0627\u0621 \u0628\u0627\u0644\u0623\u062c\u0647\u0632\u0629 \u0627\u0644\u0623\u0643\u062b\u0631 \u0627\u0628\u062a\u0643\u0627\u0631\u0627 - ICT Business Magazine - \u0623\u064a \u0633\u064a \u062a\u064a \u0628\u064a\u0632\u0646\u0633",
                description: "\u0623\u0639\u0644\u0646\u062a \u0634\u0631\u0643\u0629 \u0633\u0644\u0643\u062a \u0644\u062a\u0643\u0646\u0648\u0644\u0648\u062c\u064a\u0627 \u0627\u0644\u0627\u062a\u0635\u0627\u0644\u0627\u062a \u0648\u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a\u060c \u0627\u0644\u0645\u062a\u062e\u0635\u0635\u0629 \u0641\u064a \u0623\u062c\u0647\u0632\u0629 \u0627\u0644\u0645\u062d\u0645\u0648\u0644 \u0648\u0627\u0644\u0625\u0644\u0643\u062a\u0631\u0648\u0646\u064a\u0627\u062a\u060c \u062a\u0648\u0642\u0639\u064a\u0647\u0627 \u0628\u0631",
                url: "http:\/\/thinakhbarak.local\/articles\/44017193--%D8%B3%D9%84%D9%83%D8%AA-%D8%AA%D9%88%D9%82%D8%B9-%D8%A7%D8%AA%D9%81%D8%A7%D9%82%D9%8A%D8%A9-%D8%AA%D8%B9%D8%A7%D9%88%D9%86-%D9%85%D8%B9-%D9%81%D8%B1%D9%8A%D8%B4",
                source: "Akhbarak.net",
                image: "https:\/\/akhbarak.net\/photos\/articles-photos\/2022\/5\/11\/44017193\/44017193-large.jpg?1652257238",
                category: "general",
                language: "ar",
                country: "eg",
                published_at: "2022-05-11T12:06:20+00:00"),
            NewsItem(
                author: nil,
                title: "\u0622\u0644\u0627\u0641 \u0627\u0644\u0645\u0634\u062c\u0639\u064a\u0646 \u064a\u062a\u062f\u0641\u0642\u0648\u0646 \u0625\u0644\u0649 \u0627\u0644\u062d\u064a \u0627\u0644\u062b\u0642\u0627\u0641\u064a \u0026quot;\u0643\u062a\u0627\u0631\u0627\u0026quot; \u0628\u0627\u0644\u062f\u0648\u062d\u0629 \u0644\u0645\u0634\u0627\u0647\u062f\u0629 \u0026quot;\u0627\u0644\u0643\u0623\u0633 \u0627\u0644\u0623\u0635\u0644\u064a\u0629\u0026quot; \u0644\u0644\u0645\u0648\u0646\u062f\u064a\u0627\u0644",
                description: "\u062a\u0648\u0627\u0641\u062f \u0645\u0633\u0627\u0621 \u0623\u0645\u0633 \u0627\u0644\u062b\u0644\u0627\u062b\u0627\u0621 \u0627\u0644\u0622\u0644\u0627\u0641 \u0645\u0646 \u0645\u0634\u062c\u0639\u064a \u0643\u0631\u0629 \u0627\u0644\u0642\u062f\u0645 \u0639\u0644\u0649 \u0627\u0644\u062d\u064a \u0627\u0644\u062b\u0642\u0627\u0641\u064a \u0643\u062a\u0627\u0631\u0627 \u0628\u0627\u0644\u0639\u0627\u0635\u0645\u0629 \u0627\u0644\u0642\u0637\u0631\u064a\u0629 \u0627\u0644\u062f\u0648\u062d\u0629\u060c \u0644\u062d\u0636\u0648\u0631 \u0627\u0644\u062d\u0641\u0644 \u0627\u0644\u062e\u062a\u0627\u0645\u064a \u0644\u0644\u0643\u0623\u0633 \u0627\u0644\u0623\u0635\u0644\u064a\u0629 \u0644\u0628\u0637\u0648\u0644\u0629 \u0643\u0623\u0633 \u0627\u0644\u0639\u0627\u0644\u0645\u060c \u0648\u0627\u0644\u0630\u064a \u062c\u0627\u0621 \u0641\u064a \u0623\u0639\u0642\u0627\u0628 \u0627\u0644\u062c\u0648\u0644\u0629 \u0627\u0644\u062a\u0631\u0648\u064a\u062c\u064a\u0629 \u0627\u0644\u062a\u064a \u0628\u062f\u0623\u062a \u0641\u064a",
                url: "http:\/\/www.elbotola.com\/article\/2022-05-10-23-09-154.html",
                source: "Elbotola.com",
                image: nil,
                category: "general",
                language: "ar",
                country: "ma",
                published_at: "2022-05-11T08:25:27+00:00")
        ]
        return newsItems
    }

    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        let pagination = Pagination(limit: 25, offset: 0, count: 25, total: 10000)
        let data = newsItems()
        let item = FeedItem(pagination: pagination, data: data)
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
}
