//
//  DashboardCollectionViewCell.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import Alamofire

class DashboardCollectionViewCell: UICollectionViewCell
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var request: Request?

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewReusableView
    ////////////////////////////////////////////////////////////

    override func prepareForReuse()
    {
        super.prepareForReuse()

        self.imageView.image = nil
    }

    ////////////////////////////////////////////////////////////

    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes)
    {
        if let attributes = layoutAttributes as? DashboardViewLayoutAttributes
        {
            if attributes.deleteButtonHidden
            {
                self.deleteButton.hidden = true
                self.stopQuivering()
            }
            else
            {
                self.deleteButton.hidden = false
                self.startQuivering()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func deleteButtonPressed(sender: UIButton)
    {
        
    }

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
        imageView.image = nil
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
        imageView.image = image
    }

    ////////////////////////////////////////////////////////////

    func startQuivering()
    {
        let quiverAnimation = CABasicAnimation(keyPath: "transform.rotation")
        let startAngle = (-2) * M_PI / 180.0
        let stopAngle = -startAngle
        quiverAnimation.fromValue = startAngle
        quiverAnimation.toValue = 2 * stopAngle
        quiverAnimation.autoreverses = true
        quiverAnimation.duration = 0.2
        quiverAnimation.repeatCount = HUGE
        let timeOffset = Double(arc4random() % 100) / 100 - 0.50
        quiverAnimation.timeOffset = timeOffset
        self.layer.addAnimation(quiverAnimation, forKey: "quivering")
    }

    ////////////////////////////////////////////////////////////

    func stopQuivering()
    {
        self.layer.removeAnimationForKey("quivering")
    }
}
