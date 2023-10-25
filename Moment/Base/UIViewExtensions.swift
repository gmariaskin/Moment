//
//  UIViewExtensions.swift
//  Moment
//
//  Created by Gleb on 25.10.2023.
//

import UIKit


extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        let scale = UIScreen.main.scale
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        
        
        self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let screenshot = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        print("Screenshot taken")
        return screenshot
        
    }
}
