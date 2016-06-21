//
//  UIColor+ThemeColors.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/19/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

extension UIColor
{
    class func primaryColor() -> UIColor
    {
        return UIColor(hex: 0x4CAF50)
    }

    ////////////////////////////////////////////////////////////

    class func lightPrimaryColor() -> UIColor
    {
        return UIColor(hex: 0xC8E6C9)
    }

    ////////////////////////////////////////////////////////////

    class func darkPrimaryColor() -> UIColor
    {
        return UIColor(hex: 0x388E3C)
    }

    ////////////////////////////////////////////////////////////

    class func accentColor() -> UIColor
    {
        return UIColor(hex: 0xFF5252)
    }

    ////////////////////////////////////////////////////////////

    class func primaryTextColor() -> UIColor
    {
        return UIColor(hex: 0x212121)
    }

    ////////////////////////////////////////////////////////////

    class func secondaryTextColor() -> UIColor
    {
        return UIColor(hex: 0x727272)
    }

    ////////////////////////////////////////////////////////////

    class func textIconColor() -> UIColor
    {
        return UIColor(hex: 0xFFFFFF)
    }

    ////////////////////////////////////////////////////////////

    class func dividerColor() -> UIColor
    {
        return UIColor(hex: 0xB6B6B6)
    }
}