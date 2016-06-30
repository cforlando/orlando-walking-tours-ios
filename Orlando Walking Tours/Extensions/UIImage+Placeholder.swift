//
//  UIImage+Placeholder.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/25/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

extension UIImage
{
    class func getPlaceholderImage(sized width: Int, by height: Int) -> UIImage?
    {
        guard let url = NSURL(string: "https://unsplash.it/\(width)/\(height)?random") else
        {
            return nil
        }

        guard let data = NSData(contentsOfURL: url) else
        {
            return nil
        }

        return UIImage(data: data)
    }
}