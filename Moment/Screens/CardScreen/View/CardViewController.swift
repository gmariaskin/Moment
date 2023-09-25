//
//  CardViewController.swift
//  Moment
//
//  Created by Gleb on 24.09.2023.
//

import UIKit

class CardViewController: CustomViewController {
    
    //MARK: - Properties
    
    private let mainView = CardView()
    
    private let testModel: [QuestionModel] = [
    QuestionModel(question: "How are you?"),
    QuestionModel(question: "Whats your name?"),
    QuestionModel(question: "Do you smoke weed?")
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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        self.mainView.cardCollection.dataSource = self
        self.mainView.cardCollection.delegate = self
        self.mainView.cardCollection.register(CardCell.self, forCellWithReuseIdentifier: CardCell.id)
        
        self.navigationItem.hidesBackButton = true
        
        let backItem = UIBarButtonItem(image: R.image.backButton(), style: .plain, target: self, action: #selector(backToCategories))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc private func backToCategories() {

        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

extension CardViewController: UICollectionViewDelegate {

}

extension CardViewController: UICollectionViewDataSource {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.id, for: indexPath) as? CardCell else { return UICollectionViewCell()}
        cell.configure(question: testModel[indexPath.row])
        return cell
    }
    
    
}
