//
//  CardViewController.swift
//  Moment
//
//  Created by Gleb on 24.09.2023.
//

import UIKit
import VerticalCardSwiper
import CoreGraphics


class CardViewController: CustomViewController {
    
    //MARK: - Properties
    
    private var cardSwiper: VerticalCardSwiper!
    private var premium: Bool = false
    private var currentCardIndex: Int = 0
    
    private let counterLabel: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayLight(size: 14)
        obj.textAlignment = .center
        obj.textColor = .black
        obj.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private let hintLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Смахните эту карточку вверх, чтобы открыть следующий вопрос"
        obj.numberOfLines = 2
        obj.textAlignment = .center
        obj.textColor = .gray
        obj.font = R.font.sfProDisplayLight(size: 12)
        obj.addCharacterSpacing(kernValue: 2)
        return obj
    }()
    
    private var questionsArray: [QuestionModel] = []
    
    //MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(with category: String, questions: [QuestionModel]) {
        super.init(nibName: nil, bundle: nil)
        self.questionsArray = questions
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
        
        counterLabel.text = "1 из \(questionsArray.count)"
        
        
        //MARK: - CardSwiper
        
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
        
        //MARK: - Navigation
        
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem(image: R.image.backButton(), style: .plain, target: self, action: #selector(backToCategories))
        let restartItem = UIBarButtonItem(image: R.image.previousCardButton(), style: .plain, target: self, action: #selector(restartItemTapped))
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem = restartItem
        
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
    
    //MARK: - Functions
    
    @objc private func backToCategories() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func restartItemTapped() {
        
        cardSwiper.scrollToCard(at: 0, animated: true)
        counterLabel.text = "1 из \(questionsArray.count)"
    }
    
    func getIndex() {
        let index = currentCardIndex + 1
        counterLabel.text = "\(index) из \(questionsArray.count)"
    }
}

//MARK: - VerticalCardSwiperDatasource


extension CardViewController: VerticalCardSwiperDatasource {
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return !premium ? questionsArray.count + 1 : questionsArray.count
    }
    
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        let cell: CardCell
        
        if !premium && index == questionsArray.count {
            guard let lastCardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: LastCardCell.identifier, for: index) as? LastCardCell else { return CardCell() }
            cell = lastCardCell
            lastCardCell.delegate = self
        } else {
            guard let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: Card.id, for: index) as? Card else { return CardCell() }
            cardCell.configure(question: questionsArray[index], color: cardColorsArray.randomElement()!)
            cell = cardCell
            cardCell.delegate = self
        }
        
        return cell
    }
    
}

//MARK: - VerticalCardSwiperDelegate

extension CardViewController: VerticalCardSwiperDelegate {
    
    func didScroll(verticalCardSwiperView: VerticalCardSwiperView) {
        currentCardIndex = cardSwiper.focussedCardIndex!
        if currentCardIndex != questionsArray.count{
            getIndex()
        } else { return }
    }
}

//MARK: - LastCardCellDelegate

extension CardViewController: LastCardCellDelegate {
    
    func restart() {
        cardSwiper.scrollToCard(at: 0, animated: true)
    }
    
    func presentAccessVC() {
        let accessVC = AccessViewController()
        accessVC.modalPresentationStyle = .pageSheet
        self.navigationController?.present(accessVC, animated: true)
        
    }
}

//MARK: - SendCardProtocolDelegate

extension CardViewController: SendCardProtocoloDelegate {
    func sendCard(card: UIImage) {
        
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [card], applicationActivities: nil)
              self.present(activityVC, animated: true)
        }
     
    }
}

