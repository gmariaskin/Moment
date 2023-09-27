//
//  CardViewController.swift
//  Moment
//
//  Created by Gleb on 24.09.2023.
//

import UIKit
import VerticalCardSwiper

class CardViewController: CustomViewController {
    
    
    
    //MARK: - Properties
    
    private var cardSwiper: VerticalCardSwiper!
    private var isLastCardDisplayed = true
    private var currentCardIndex = 0
    
    private let counterLabel: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayLight(size: 14)
        obj.textAlignment = .center
        obj.textColor = .black
        return obj
    }()
    
    
    private let hintLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Смахните эту карточку вверх, чтобы открыть следующий вопрос"
        obj.numberOfLines = 2
        obj.textAlignment = .center
        obj.textColor = .gray
        obj.font = R.font.sfProDisplayLight(size: 12)
        return obj
    }()
    
    
    private let testModel: [QuestionModel] = [
        QuestionModel(question: "How are you?"),
        QuestionModel(question: "Whats your name?"),
        QuestionModel(question: "Do you smoke?"),
        QuestionModel(question: "How are me?"),
        QuestionModel(question: "Whats my type?"),
        QuestionModel(question: "How old are you?"),
        QuestionModel(question: "Whats your dogs name?"),
    ]
    
    //MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    init(with category: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        
        cardSwiper = VerticalCardSwiper(frame: self.view.bounds.inset(by: UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20)))
        
        view.addSubview(counterLabel)
        view.addSubview(cardSwiper)
        view.addSubview(hintLabel)
        
        cardSwiper.layer.shadowRadius = 5
        cardSwiper.layer.shadowOpacity = 0.1
        cardSwiper.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        cardSwiper.cardSpacing = 50
        cardSwiper.isStackingEnabled = true
        cardSwiper.stackedCardsCount = 2
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        cardSwiper.register(Card.self, forCellWithReuseIdentifier: Card.id)
        cardSwiper.register(LastCardCell.self, forCellWithReuseIdentifier: LastCardCell.identifier)
        
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem(image: R.image.backButton(), style: .plain, target: self, action: #selector(backToCategories))
        self.navigationItem.leftBarButtonItem = backItem
        
        counterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        hintLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(55)
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    @objc private func backToCategories() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

extension CardViewController: VerticalCardSwiperDatasource {
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return isLastCardDisplayed ? testModel.count + 1 : testModel.count
    }
    
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cell: CardCell
        
        if isLastCardDisplayed && index == testModel.count {
            guard let lastCardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: LastCardCell.identifier, for: index) as? LastCardCell else { return CardCell() }
            cell = lastCardCell
        } else {
            guard let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: Card.id, for: index) as? Card else { return CardCell() }
            cardCell.configure(question: testModel[index])
            cell = cardCell
        }
        
        currentCardIndex = index
        
        counterLabel.text = "\(currentCardIndex) из \(testModel.count)"
        
        return cell
    }

    
    
    
}






extension CardViewController: VerticalCardSwiperDelegate {
    
   
}




