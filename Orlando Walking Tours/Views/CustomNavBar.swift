//
//  CustomNavBar.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 7/12/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class CustomNavBar: UINavigationBar
{
    override func drawRect(rect: CGRect)
    {
        if let navBarFont = UIFont(name: "Ubuntu", size: 18.0)
        {
            let navBarAttributesDictionary: [String: AnyObject]? =
            [
                    NSFontAttributeName: navBarFont
            ]

            self.titleTextAttributes = navBarAttributesDictionary
        }
    }

}
