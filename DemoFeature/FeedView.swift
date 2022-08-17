//
//  FeedView.swift
//  DemoFeature
//
//  Created by Tri Le on 8/15/22.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var model = FeedViewModel()

    var body: some View {
        List(model.stories.indices) { index in
            
        }
        .navigationTitle("Feed")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
        }
        .previewLayout(.sizeThatFits)
    }
}
