//
//  CurrentLocationTableViewCell.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 7/11/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import Alamofire

class CurrentLocationTableViewCell: UITableViewCell, ReusableView
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationThumbnail: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var request: Request?

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func configureImage(frame: CGRect)
    {
        reset()
        loadImage(width: frame.width, height: frame.height)
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

        request = UIImage.getPlaceholderImage(sized: Int(width), by: Int(height))
        { image in
            self.populateCell(image: image!)
        }
    }

    ////////////////////////////////////////////////////////////

    func populateCell(image: UIImage)
    {
        loadingIndicator.stopAnimating()
        locationThumbnail.image = image
    }
}
