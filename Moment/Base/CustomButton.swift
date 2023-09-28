//
//  CustomButton.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = R.color.customButtonBackgroundColor()
        layer.borderWidth = 1
        layer.borderColor = R.color.customButtonBorderColor()?.cgColor
        
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        self.layer.cornerRadius = 22
        self.layer.borderColor = R.color.customButtonBorderColor()?.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
}
