//
//  CustomButton.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/19/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton
{
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    @IBInspectable
    var colorCode: Int = 0
    {
        didSet
        {
            self.backgroundColor = setColor(colorCode)
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat = 3.0
    {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable
    var fontColor: Int = 0
    {
        didSet
        {
            self.tintColor = setColor(fontColor)
        }
    }

    ////////////////////////////////////////////////////////////

    func setColor(colorCode: Int) -> UIColor
    {
        switch colorCode
        {
        case 1:
            return UIColor.primaryColor()
        case 2:
            return UIColor.lightPrimaryColor()
        case 3:
            return UIColor.darkPrimaryColor()
        case 4:
            return UIColor.accentColor()
        case 5:
            return UIColor.primaryTextColor()
        case 6:
            return UIColor.secondaryTextColor()
        case 7:
            return UIColor.textIconColor()
        case 8:
            return UIColor.dividerColor()
        default:
            return UIColor.blackColor()
        }
    }
}
