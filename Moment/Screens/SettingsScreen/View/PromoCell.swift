//
//  PromoCell.swift
//  Moment
//
//  Created by Gleb on 29.09.2023.
//


//MARK: - TODO 

import UIKit

protocol PromoCellDelegate: AnyObject {
    func goToAccessScreen()
}

class PromoCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let id = String(describing: PromoCell.self)
    weak var delegate: PromoCellDelegate?
    
    private let promoView: UIView = {
        let obj = UIView()
        obj.layer.cornerRadius = 24
        obj.backgroundColor = .white
        obj.layer.shadowRadius = 5
        obj.layer.shadowOpacity = 0.1
        obj.layer.shadowOffset = CGSize(width: 0, height: 10)
        obj.layer.borderWidth = 1
        obj.layer.borderColor = R.color.customButttonGrayBorder()?.cgColor
        obj.isUserInteractionEnabled = true
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
        obj.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    let unlockCardsButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Открыть все карточки", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        return obj
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {

        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(promoView)
        promoView.addSubview(logoImageView)
        promoView.addSubview(cardsImageView)
        promoView.addSubview(promoLabel)
        addSubview(unlockCardsButton)
        
        unlockCardsButton.titleLabel?.addCharacterSpacing(kernValue: 2)
        unlockCardsButton.addTarget(self, action: #selector(unlockTapped), for: .touchUpInside)
        
        promoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    }
    
    @objc private func unlockTapped() {
        delegate?.goToAccessScreen()
    }
}
