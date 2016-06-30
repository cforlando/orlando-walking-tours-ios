//
//  DashboardCollectionViewCell.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    ////////////////////////////////////////////////////////////

    override func prepareForReuse()
    {
        super.prepareForReuse()

        self.imageView.image = nil
    }

    ////////////////////////////////////////////////////////////

    @IBAction func deleteButtonPressed(sender: UIButton)
    {
        
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
}
