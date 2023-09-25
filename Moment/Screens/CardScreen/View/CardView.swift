//
//  CardView.swift
//  Moment
//
//  Created by Gleb on 24.09.2023.
//

import UIKit


class CardView: UIView {
    
    //MARK: - Properties
    
    private let hintLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Смахните карточку влево или вправо, чтобы открыть следующий вопрос"
        obj.numberOfLines = 2
        obj.textAlignment = .center
        obj.textColor = .gray
        obj.font = R.font.sfProDisplayLight(size: 12)
        return obj
    }()
    
    let cardCollection: UICollectionView = {
        let layout = UICollectionViewLayout()
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.isPagingEnabled = true
        obj.showsHorizontalScrollIndicator = true
        obj.backgroundColor = .gray
        
        
        return obj
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = .white
        
        addSubview(cardCollection)
        addSubview(hintLabel)
      
        
        hintLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(55)
            make.bottom.equalToSuperview().inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        cardCollection.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalTo(hintLabel.snp.top)
        }
    }
}
