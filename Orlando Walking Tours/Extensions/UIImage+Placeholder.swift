//
//  UIImage+Placeholder.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/25/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImage
{
    class func getPlaceholderImage(sized width: Int, by height: Int, completion: @escaping ((UIImage?) -> Void)) -> Request
    {
        let urlString = "https://unsplash.it/\(width)/\(height)?random"

        return Alamofire.request(urlString).responseImage
        { response in
            guard let image = response.result.value else
            {
                return
            }

            completion(image)
        }
    }
}
