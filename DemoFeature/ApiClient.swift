//
//  ApiClient.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import Foundation

// Main Module

extension ApiClient {
    func login(completion: (LoggedInUser) -> Void) {}
}

extension ApiClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {}
}

// Api Module

class ApiClient {
    static let shared = ApiClient()

    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

class MockApiClient: ApiClient {}

// Login Module

struct LoggedInUser {}

class LoginViewModel {
    var login: (((LoggedInUser) -> Void) -> Void)?

    func didTapLoginButton() {
        login? { user in
            // show next screen
        }
    }
}

// Feed Module

//struct FeedItem {}

class FeedViewModel {
    var loadFeed: (((LoggedInUser) -> Void) -> Void)?

    func load() {
        loadFeed? { loadedItems in
            // update UI
        }
    }
}
