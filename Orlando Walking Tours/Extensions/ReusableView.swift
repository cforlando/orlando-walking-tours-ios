//
//  ReusableView.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 7/11/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView
{
    static var reuseIdentifier: String
    {
        return String(describing: self)
    }
}
