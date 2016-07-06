//
//  LocationTableViewCell.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/7/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    var locationId: String!
    @IBOutlet weak var locationThumbnail: UIImageView!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var addLocationButton: UIButton!
}
