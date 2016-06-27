//
//  DashboardViewLayoutAttributes.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/26/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardViewLayoutAttributes: UICollectionViewLayoutAttributes
{
    var deleteButtonHidden: Bool = true
    
    ////////////////////////////////////////////////////////////

    override func copyWithZone(zone: NSZone) -> AnyObject
    {
        let attributes = super.copyWithZone(zone) as! DashboardViewLayoutAttributes
        attributes.deleteButtonHidden = self.deleteButtonHidden
        return attributes
    }
}
