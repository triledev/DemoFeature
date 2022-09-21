//
//  FeedItemCell.swift
//  Prototype
//
//  Created by Tri Le on 9/20/22.
//

import UIKit

final class FeedItemCell: UITableViewCell {
    @IBOutlet private(set) var locationContainer: UIView!
    @IBOutlet private(set) var locationLabel: UILabel!
    @IBOutlet private(set) var feedItemView: UIImageView!
    @IBOutlet private(set) var descriptionLabel: UILabel!
}
