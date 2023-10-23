//
//  CardCell.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import SnapKit
import VerticalCardSwiper

class Card: CardCell {
    
    //MARK: - Properties
    
    static let id = String(describing: Card.self)
    
    private let logo : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.smallLogo()
        return obj
    }()
    
    private let sendButton : UIButton = {
        let obj = UIButton()
        obj.setImage(R.image.share(), for: .normal)
        return obj
    }()
    
    private let questionLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        obj.font = R.font.sfProDisplayRegular(size: 28)
        obj.numberOfLines = 0
        obj.addCharacterSpacing(kernValue: 2)
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
        
        layer.cornerRadius = 24
        layer.borderWidth = 1
        
        addSubview(logo)
        addSubview(questionLabel)
        addSubview(sendButton)
        
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(44)
            
        }
        
        sendButton.snp.makeConstraints { make in
            
            make.bottom.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configure(question: QuestionModel, color: CardColor) {
        self.questionLabel.text = question.Question
        self.backgroundColor = color.bgColor
        self.layer.borderColor = color.outColor.cgColor
        self.questionLabel.textColor = color.textColor
    }
    
}
