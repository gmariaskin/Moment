//
//  LastCardCell.swift
//  Moment
//
//  Created by Gleb on 26.09.2023.
//

import UIKit
import SnapKit
import VerticalCardSwiper

class LastCardCell: CardCell {
    
    //MARK: - Properties
    
    private let logo : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.smallLogo()
        return obj
    }()
    
    private let image : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.lockedHeart()
        return obj
    }()
    
    private let label: UILabel = {
        let obj = UILabel()
        obj.text = "Бесплатные\nкарточки\nзакончились"
        obj.font = R.font.sfProDisplayLight(size: 28)
        obj.textAlignment = .center
        obj.numberOfLines = 3 
        obj.textColor = .black
        return obj
    }()
    
    private let unlockButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Открыть все карточки", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        return obj
    }()
    
    private let startAgainButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Начать сначала", for: .normal)
        obj.setTitleColor(.black, for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.backgroundColor = .white
        obj.layer.borderWidth = 1
        obj.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return obj
    }()
    
    
    static let identifier = "LastCardCell"
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        
        self.backgroundColor = .white
        layer.cornerRadius = 24
        
        addSubview(logo)
        addSubview(image)
        addSubview(label)
        addSubview(unlockButton)
        addSubview(startAgainButton)
        
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
        }
        
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(52)
            make.size.equalTo(92)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(image.snp.bottom)
            make.height.equalTo(108)
        }
        
        unlockButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
        startAgainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(unlockButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(74.5)
        }
    }
    
}
