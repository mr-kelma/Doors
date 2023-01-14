//
//  CustomFont.swift
//  Doors
//
//  Created by Valery Keplin on 11.01.23.
//

import UIKit

enum FontWeight: String {
    case bold = "Sk-Modernist-Bold"
    case regular = "Sk-Modernist-Regular"
}

extension UIFont {
    static func skModernist(style: FontWeight.RawValue, size: CGFloat) -> UIFont {
        let style = style
        guard let skModernist = UIFont(name: style, size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return skModernist
    }
}
