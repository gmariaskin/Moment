//
//  CustomSubscriptionButton.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

class CustomSubscriptionButton: UIButton {
    
    //MARK: - Properties
    
    private let price: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayRegular(size: 28)
        obj.textAlignment = .center
        obj.textColor = .black
        return obj
    }()
    
    private let time: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayLight(size: 16)
        obj.textColor = .darkGray
        obj.textAlignment = .center
        return obj
    }()
    
    private let check : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.checkmarkIcon()
        return obj
    }()
    
    
    
    //MARK: - Lifecycle
    
    init(price: String, time: String) {
        super.init(frame: .zero)
        self.price.text = "\(price) ₽"
        self.time.text = time
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = R.color.customButttonGrayBorder()?.cgColor
        check.image = R.image.emptyCheckmarkIcon()
   
        backgroundColor = .white
        
        addSubview(price)
        addSubview(time)
        addSubview(check)
       
        
        price.addCharacterSpacing(kernValue: 2)
        time.addCharacterSpacing(kernValue: 2)
        
        price.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        time.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(price.snp.bottom)
        }
        
        check.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(time.snp.bottom).offset(16)
        }
    }
    
    func configure(chosen: Bool) {
        if chosen {
            self.layer.borderColor = R.color.customButtonTextColor()?.cgColor
            self.check.image = R.image.checkmarkIcon()
        } else {
            self.layer.borderColor = R.color.customButttonGrayBorder()?.cgColor
            self.check.image = R.image.emptyCheckmarkIcon()
        }
    }
    
}
