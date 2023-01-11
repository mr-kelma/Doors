//
//  CustomFont.swift
//  Doors
//
//  Created by Valery Keplin on 11.01.23.
//

import UIKit

extension UIFont {
    static func customFont(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Sk-Modernist-Bold", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
}
