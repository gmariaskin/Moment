//
//  AccessView.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import RevenueCat

class AccessView: UIView {
    
    //MARK: - Properties
  
    let closeButton : UIButton = {
        let obj = UIButton()
        obj.setImage(R.image.crossButton(), for: .normal)
        return obj
    }()
    
    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Получить \n доступ ко всем карточками"
        obj.font = R.font.sfProDisplayLight(size: 28)
        obj.numberOfLines = 3
        obj.textAlignment = .center
        obj.addCharacterSpacing(kernValue: 2)
        obj.textColor = .black
        return obj
    }()
    
    private let feature1: UIView = {
        let obj = CustomFeatureLabel(title: "Более 200 карточек с вопросами,\n которые помогут вам узнать\n себя и друг друга лучше")
        return obj
    }()
    
    private let feature2: UIView = {
        let obj = CustomFeatureLabel(title: "Будущие обновления\nприложения")
        return obj
    }()
    
    private let feature3: UIView = {
        let obj = CustomFeatureLabel(title: "Скидка на услуги коуча\nВиктории Белых")
        return obj
    }()
    
    let price1 : CustomSubscriptionButton = {
        let obj = CustomSubscriptionButton(price: "299₽", time: "в месяц")
        obj.layer.shadowRadius = 5
        obj.layer.shadowOpacity = 0.1
        obj.layer.shadowOffset = CGSize(width: 0, height: 10)
        return obj
    }()
    
    let price2 : CustomSubscriptionButton = {
        let obj = CustomSubscriptionButton(price: "2490₽", time: "в год")
        obj.layer.shadowRadius = 5
        obj.layer.shadowOpacity = 0.1
        obj.layer.shadowOffset = CGSize(width: 0, height: 10)
        return obj
    }()
    
     let freeTrialButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Начать с недели бесплатно", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.layer.borderWidth = 1
        
        return obj
    }()
    
    private let termsLabel: UILabel = {
        let obj = UILabel()
        obj.text = "7 дней бесплатно, затем 299 ₽ в месяц.\nОтменить можно в любой момент."
        obj.textColor = .darkGray
        obj.textAlignment = .center
        obj.font = R.font.sfProDisplayLight(size: 12)
        obj.numberOfLines = 2
        obj.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
     let restorePurchaseButton : UIButton = {
        let obj = UIButton()
        obj.setTitle("Восстановить покупку", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
     let termsButton : UIButton = {
        let obj = UIButton()
        obj.setTitle("Условия использования", for: .normal)
        obj.setTitleColor(.darkGray, for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 12)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
     let privacyButton : UIButton = {
        let obj = UIButton()
        obj.setTitle("Политика конфиденциальности", for: .normal)
        obj.setTitleColor(.darkGray, for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 12)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        backgroundColor = .white
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(feature1)
        addSubview(feature2)
        addSubview(feature3)
        addSubview(price1)
        addSubview(price2)
        addSubview(freeTrialButton)
        addSubview(termsLabel)
        addSubview(restorePurchaseButton)
        addSubview(termsButton)
        addSubview(privacyButton)
        
        freeTrialButton.titleLabel?.addCharacterSpacing(kernValue: 2)
        
        
        closeButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.height.lessThanOrEqualTo(108)
        }
        
        feature1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(60).priority(900)
        }
        
        
        
        feature2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.lessThanOrEqualTo(feature1.snp.bottom).offset(24)
            make.height.lessThanOrEqualTo(48).priority(1000)
        }
        
        feature3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(feature2.snp.bottom).offset(24).priority(900)
            make.height.lessThanOrEqualTo(48).priority(900)
        }
        
        price1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(feature3.snp.bottom).offset(32)
//            make.bottom.lessThanOrEqualTo(freeTrialButton.snp.top).inset(25).priority(600)
            make.height.equalTo(128)
            make.width.equalTo(154.5)
        }
        
        price2.snp.makeConstraints { make in
            make.leading.equalTo(price1.snp.trailing).offset(17)
            make.top.equalTo(feature3.snp.bottom).offset(32)
//            make.bottom.lessThanOrEqualTo(freeTrialButton.snp.top).inset(25).priority(600)
            make.height.equalTo(128)
            make.width.equalTo(154.5)
        }
        
        freeTrialButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(price1.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(62.5)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(freeTrialButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.lessThanOrEqualTo(32)
        }
        
        restorePurchaseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(termsLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.lessThanOrEqualTo(20)
        }
        
        termsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(restorePurchaseButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.lessThanOrEqualTo(16)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(termsButton.snp.bottom).offset(16)
            make.height.equalTo(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().inset(20)
        }
        
    }
}
