//
//  LastCardCell.swift
//  Moment
//
//  Created by Gleb on 26.09.2023.
//

import UIKit
import SnapKit
import VerticalCardSwiper

protocol LastCardCellDelegate: AnyObject {
    func restart()
    func presentAccessVC()
}

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
        obj.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let unlockButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Открыть все карточки", for: .normal)
        obj.setTitleColor(R.color.customButtonTextColor(), for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let startAgainButton : CustomButton = {
        let obj = CustomButton()
        obj.setTitle("Начать сначала", for: .normal)
        obj.setTitleColor(.black, for: .normal)
        obj.titleLabel?.font = R.font.sfProDisplayLight(size: 14)
        obj.backgroundColor = .clear
        obj.layer.borderWidth = 1
        obj.layer.borderColor = R.color.customButttonGrayBorder()?.cgColor
        obj.titleLabel?.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let obj = UIVisualEffectView(effect: blur)
        return obj
    }()
    
    static let identifier = "LastCardCell"
    weak var delegate: LastCardCellDelegate?
    
    
    
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
        
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        layer.cornerRadius = 24
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = R.color.customButttonGrayBorder()?.cgColor
        
        insertSubview(blurView, at: 0)
        addSubview(logo)
        addSubview(image)
        addSubview(label)
        addSubview(unlockButton)
        addSubview(startAgainButton)
        
        startAgainButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
    
    
    @objc private func restartTapped() {
        delegate?.restart()
    }
    
    
    @objc private func unlockButtonTapped() {
        delegate?.presentAccessVC()
    }
    
}
