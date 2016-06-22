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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tourName: UILabel!

    override func prepareForReuse()
    {
        super.prepareForReuse()

        self.imageView.image = nil
    }
    
}
