//
//  UIColor+Theme.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 25/2/22.
//

import Foundation
import UIKit

extension UIColor {
    static var orange: UIColor {
        return .init(red: 255/255.0, green: 173/255.0, blue: 0/255.0, alpha: 1)
    }
    
    static var orange70: UIColor {
        return .orange.withAlphaComponent(0.7)
    }
}
