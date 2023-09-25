//
//  SettingsView.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

class SettingsView: UIView {
    
    //MARK: - Properties
    
    private let promoView: UIView = {
        let obj = UIView()
        obj.layer.cornerRadius = 24
        obj.backgroundColor = .white
        return obj
    }()
    
    private let logoImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.smallLogo()
        return obj
    }()
    
    private let cardsImageView : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.cards()
        return obj
    }()
    
    private let promoLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Вы попробовали приложение и вам понравилось?"
        obj.numberOfLines = 2
        obj.textAlignment = .center
        obj.font = R.font.sfProDisplayLight(size: 16)
        return obj
    }()
    
    
    private let unlockCardsButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Открыть все карточки", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        return obj
    }()
    
    let settingstableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .insetGrouped)
        obj.rowHeight = UITableView.automaticDimension
        obj.backgroundColor = .clear
        obj.separatorStyle = .singleLine
        return obj
    }()
    
    private let copyright : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.copyright()
        return obj
    }()
    
    //MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
      
        addSubview(promoView)
        promoView.addSubview(logoImageView)
        promoView.addSubview(cardsImageView)
        promoView.addSubview(promoLabel)
        promoView.addSubview(unlockCardsButton)
        addSubview(settingstableView)
        addSubview(copyright)
        
        
        promoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(292)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        cardsImageView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        promoLabel.snp.makeConstraints { make in
            make.top.equalTo(cardsImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        unlockCardsButton.snp.makeConstraints { make in
            make.top.equalTo(promoLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(69)
        }
        
        settingstableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
            make.top.equalTo(promoView.snp.bottom).offset(16)
        }
        
        copyright.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(settingstableView.snp.bottom).offset(32)
        }
    }

}
