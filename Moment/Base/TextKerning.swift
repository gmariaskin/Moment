//
//  TextKerning.swift
//  Moment
//
//  Created by Gleb on 27.09.2023.
//

import UIKit

extension UILabel {
    
    func addCharacterSpacing(kernValue: Double = 3) {
           if let labelText = text, labelText.isEmpty == false {
               let attributedString = NSMutableAttributedString(string: labelText)
               attributedString.addAttribute(.kern,
                                             value: kernValue,
                                             range: NSRange(location: 0, length: attributedString.length - 1))
               attributedText = attributedString
           }
       }
}
