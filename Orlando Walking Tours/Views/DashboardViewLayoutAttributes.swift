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

    override func copy(with zone: NSZone?) -> Any
    {
        let attributes = super.copy(with: zone) as! DashboardViewLayoutAttributes
        attributes.deleteButtonHidden = self.deleteButtonHidden
        return attributes
    }

    ////////////////////////////////////////////////////////////

    override func isEqual(_ object: Any?) -> Bool
    {
        if let customAttributes = object as? DashboardViewLayoutAttributes
        {
            if self.deleteButtonHidden == customAttributes.deleteButtonHidden
            {
                return super.isEqual(object)
            }
        }

        return false
    }
}
