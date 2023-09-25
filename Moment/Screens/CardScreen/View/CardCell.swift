//
//  CardCell.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import SnapKit

class CardCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let colorsArray: [UIColor] = [R.color.color1()!,
                       R.color.color2()!,
                       R.color.color3()!,
                       R.color.color4()!,
                       R.color.color5()!,
                       R.color.color6()!,
                       R.color.color7()!,
                       R.color.color8()!,
                       R.color.color9()!,
                       R.color.color10()!,
                       R.color.color11()!,
                       R.color.color12()!,
                       R.color.color13()!,
                       R.color.color14()!,
                       R.color.color15()!,
                       R.color.color16()!,
                       R.color.color17()!,
                       R.color.color18()!,
    ]
    
    static let id = String(describing: CardCell.self)
    
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
            make.top.equalTo(questionLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configure (question: QuestionModel ){
        self.backgroundColor = colorsArray.randomElement()
        self.questionLabel.text = question.question
    }
}
