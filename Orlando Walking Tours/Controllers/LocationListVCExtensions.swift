//
//  LocationListVCExtensions.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 7/1/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension HistoricLocation {
    var locationId: String {
        return String(format: "%f%f", latitude! as Double, longitude! as Double)
    }
    // might cache this on HistoricLocation
    var locationPoint: CLLocation {
        return CLLocation(latitude: self.latitude! as Double, longitude: self.longitude! as Double)
    }
}

extension CLLocationCoordinate2D : Equatable {
}
public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
}

class TouchableLabel : UILabel {
    var didTouch: (() -> Void)!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        didTouch()
    }
}

extension CLLocationDistance {
    var asMiles: Double {
        return self / 1609.344
    }
}
extension Double {
    var asMeters: Double {
        return self * 1609.344
    }    
}

extension UIView {
    
    func findSuperViewOfType<T>(superViewClass : T.Type) -> UIView? {
        
        var xsuperView : UIView! = self.superview!
        var foundSuperView : UIView!
        
        while (xsuperView != nil && foundSuperView == nil) {
            if xsuperView.self is T {
                foundSuperView = xsuperView
            } else {
                xsuperView = xsuperView.superview
            }
        }
        return foundSuperView
    }
    
    // makes calling code easier to read in some cases
    var shown: Bool {
        get {
            return !self.hidden
        }
        set {
            self.hidden = !newValue
        }
    }
}
