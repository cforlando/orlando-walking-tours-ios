//
//  LocationTableViewCell.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/7/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import Alamofire

class LocationTableViewCell: UITableViewCell, ReusableView
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var locationThumbnail: UIImageView!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    // TODO: Find out what the purpose of this property is
    var locationId: String!
    var request: Request?

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func configureImage(frame: CGRect)
    {
        reset()
        loadImage(frame.width, height: frame.height)
    }

    ////////////////////////////////////////////////////////////

    func reset()
    {
        locationThumbnail.image = nil
        request?.cancel()
    }

    ////////////////////////////////////////////////////////////

    func loadImage(width: CGFloat, height: CGFloat)
    {
        loadingIndicator.startAnimating()

        // TODO: Image view for cell should be random photo of a location from the tour
        request = UIImage.getPlaceholderImage(sized: Int(width), by: Int(height))
        { image in
            self.populateCell(image)
        }
    }

    ////////////////////////////////////////////////////////////

    func populateCell(image: UIImage?)
    {
        loadingIndicator.stopAnimating()
        locationThumbnail.image = image
    }
}
