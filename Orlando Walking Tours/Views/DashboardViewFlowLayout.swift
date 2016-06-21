//
//  DashboardViewFlowLayout.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardViewFlowLayout: UICollectionViewFlowLayout
{
    override var itemSize: CGSize
    {
        set
        {

        }

        get
        {
            let itemWidth = CGRectGetWidth(self.collectionView!.frame) / 2.0
            return CGSizeMake(itemWidth, itemWidth)
        }
    }

    override init()
    {
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout()
    {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Vertical
    }
}
