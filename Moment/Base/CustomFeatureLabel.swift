//
//  CustomFeatureLabel.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import SnapKit

class CustomFeatureLabel: UIView {
    
    //MARK: - Properties
    
    private let check : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.checkmarkIcon()
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayLight(size: 16)
        obj.textColor = .darkGray
        obj.textAlignment = .left
        obj.numberOfLines = 0
        return obj
    }()
    
    
    //MARK: - Lifecycle
    
    init(title: String) {
         super.init(frame: .zero)
         nameLabel.text = title
         setup()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        addSubview(check)
        addSubview(nameLabel)
        
        check.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.size.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(check.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.top.equalTo(check.snp.top)
        }
    }
    
  
}
