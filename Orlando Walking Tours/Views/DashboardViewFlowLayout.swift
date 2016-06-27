//
//  DashboardViewFlowLayout.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

protocol DashboardViewLayoutDelegate
{
    func isDeletionModeActiveForCollectionView(collectionView: UICollectionView, layout: UICollectionViewLayout) -> Bool
}

////////////////////////////////////////////////////////////

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

    ////////////////////////////////////////////////////////////

    override init()
    {
        super.init()
        setupLayout()
    }

    ////////////////////////////////////////////////////////////

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupLayout()
    }

    ////////////////////////////////////////////////////////////

    func setupLayout()
    {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        scrollDirection = .Vertical
    }

    ////////////////////////////////////////////////////////////

    func isDeletionModeOn() -> Bool
    {
        if let collectionView = self.collectionView,
           let delegate = collectionView.delegate as? DashboardViewLayoutDelegate
        {
            return delegate.isDeletionModeActiveForCollectionView(collectionView, layout: self)
        }
        return false
    }

    ////////////////////////////////////////////////////////////

    override class func layoutAttributesClass() -> AnyClass
    {
        return DashboardViewLayoutAttributes.self
    }

    ////////////////////////////////////////////////////////////

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        if let attributes = super.layoutAttributesForItemAtIndexPath(indexPath) as? DashboardViewLayoutAttributes
        {
            attributes.deleteButtonHidden = isDeletionModeOn() ? false : true
            return attributes
        }

        return nil
    }

    ////////////////////////////////////////////////////////////

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        if let attributesArrayInRect = super.layoutAttributesForElementsInRect(rect)
        {
            for attributes in attributesArrayInRect
            {
                if let attributes = attributes as? DashboardViewLayoutAttributes
                {
                    attributes.deleteButtonHidden = isDeletionModeOn() ? false : true
                }
            }

            return attributesArrayInRect
        }

        return nil
    }
}
