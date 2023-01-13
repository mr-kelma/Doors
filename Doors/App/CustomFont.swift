//
//  CustomFont.swift
//  Doors
//
//  Created by Valery Keplin on 11.01.23.
//

import UIKit

extension UIFont {
    static func skModernist(style: String, size: CGFloat) -> UIFont {
        let style = "Sk-Modernist-\(style)"
        guard let skModernist = UIFont(name: style, size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return skModernist
    }
}
