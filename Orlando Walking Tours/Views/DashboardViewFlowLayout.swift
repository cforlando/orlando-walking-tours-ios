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
            let itemWidth = self.collectionView!.frame.width / 2.0
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }

    ////////////////////////////////////////////////////////////

    override class var layoutAttributesClass: AnyClass
    {
        get
        {
            return DashboardViewLayoutAttributes.self
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
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }

    ////////////////////////////////////////////////////////////

    func isDeletionModeOn() -> Bool
    {
        if let collectionView = self.collectionView,
           let delegate = collectionView.delegate as? DashboardViewLayoutDelegate
        {
            return delegate.isDeletionModeActiveForCollectionView(collectionView: collectionView, layout: self)
        }
        return false
    }

    ////////////////////////////////////////////////////////////

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        if let attributes = super.layoutAttributesForItem(at: indexPath) as? DashboardViewLayoutAttributes
        {
            attributes.deleteButtonHidden = isDeletionModeOn() ? false : true
            return attributes
        }

        return nil
    }

    ////////////////////////////////////////////////////////////

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        if let attributesArrayInRect = super.layoutAttributesForElements(in: rect)
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
