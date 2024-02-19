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
        let obj = CustomFeatureLabel(title: "1462 карточки с вопросами,\n которые помогут вам узнать\n себя и друг друга лучше")
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
        let obj = CustomSubscriptionButton(price: "299", time: "на месяц")
        obj.layer.shadowRadius = 5
        obj.layer.shadowOpacity = 0.1
        obj.layer.shadowOffset = CGSize(width: 0, height: 10)
        return obj
    }()
    
    let price2 : CustomSubscriptionButton = {
        let obj = CustomSubscriptionButton(price: "2490", time: "на всю жизнь")
        obj.layer.shadowRadius = 5
        obj.layer.shadowOpacity = 0.1
        obj.layer.shadowOffset = CGSize(width: 0, height: 10)
        return obj
    }()
    
    private let freeTrialButton : CustomButton = {
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
    
    private let restorePurchaseButton : UIButton = {
        let obj = UIButton()
        obj.setTitle("Восстановить покупку", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let termsButton : UIButton = {
        let obj = UIButton()
        obj.setTitle("Условия использования", for: .normal)
        obj.setTitleColor(.darkGray, for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 12)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let privacyButton : UIButton = {
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
        
        setupProducts()
        
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
            make.height.equalTo(108)
        }
        
        feature1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(72)
        }
        
        feature2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(feature1.snp.bottom).offset(24)
            make.height.equalTo(48)
        }
        
        feature3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(feature2.snp.bottom).offset(24)
            make.height.equalTo(48)
        }
        
        price1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(feature3.snp.bottom).offset(32)
            make.height.equalTo(132)
            make.width.equalTo(154.5)
        }
        
        price2.snp.makeConstraints { make in
            make.leading.equalTo(price1.snp.trailing).offset(17)
            make.top.equalTo(feature3.snp.bottom).offset(32)
            make.height.equalTo(132)
            make.width.equalTo(154.5)
        }
        
        freeTrialButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(price1.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(62.5)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(freeTrialButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(32)
        }
        
        restorePurchaseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        termsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(restorePurchaseButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(16)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsButton.snp.bottom).offset(16)
            make.height.equalTo(16)
            make.horizontalEdges.equalToSuperview()
        }
        
    }
    
    private func setupProducts() {
        
        Purchases.shared.getOfferings { (offerings, error) in
            if let product = offerings?.current?.monthly?.storeProduct {
                         
                        }
        }
    }
    
}
