//
//  CategoriesViewController.swift
//  Moment
//
//  Created by Gleb on 23.09.2023.
//

import UIKit
import RevenueCat


class CategoriesViewController: CustomViewController {
    
    
    
    //MARK: - Properties
    
    private let mainView = CategoriesView()
    
    var allQuestions: [QuestionModel] = []
    var vKompaniiQuestions: [QuestionModel] = []
    var obmenOpitomQuestions: [QuestionModel] = []
    var vSebeQuestions: [QuestionModel] = []
    var naSvidaniiQuestions: [QuestionModel] = []
    var freeQuestions: [QuestionModel] = []
    var premiumQuestions: [QuestionModel] = []
    
    let userDefaults = UserDefaults.standard
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        setup()
    }
    
    //MARK: - Actions
    
    private func fetchQuestions() {
        
        let manager = FirebaseManager.shared
       
        manager.getQuestions { questions in
            self.vKompaniiQuestions = questions.filter { $0.Category == "В компании" }
            self.obmenOpitomQuestions = questions.filter { $0.Category == "Обмен опытом" }
            self.vSebeQuestions = questions.filter { $0.Category == "Разобраться в себе" }
            self.naSvidaniiQuestions = questions.filter { $0.Category == "На свидании" }
        }
      
    }
    
    private func setup() {
        
        self.navigationItem.title = "Категории"
        
        let settingsItem = UIBarButtonItem(image: R.image.settings(), style: .plain, target: self, action: #selector(goToSettings))
        self.navigationItem.leftBarButtonItem = settingsItem
        
        mainView.categoriesTableView.dataSource = self
        mainView.categoriesTableView.delegate = self
        mainView.categoriesTableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.id)
    }
    
    @objc private func goToSettings() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
    //MARK: - Model
    
    private let categories: [Category]  =
    [
        Category(title: "В компании", count: 60, description: "Веселитесь и узнавайте\nдруг друга лучше", color: R.color.color7()!, image: R.image.mechtiIcon()!),
        Category(title: "Обмен опытом", count: 34, description: "Обмениватейсь знаниями\nи расширяйте кругозор", color: R.color.color6()!, image:  R.image.hobbiIcon()!),
        Category(title: "Разобраться в себе", count: 66, description: "Лучшие места и планы на\nбудущее", color: R.color.color3()!, image:  R.image.travelIcon()!),
        Category(title: "На свидании", count: 55, description: "Важные вопросы\nдля влюбленных", color: R.color.color9()!, image:  R.image.valuesIcon()!)
    ]
    
}

//MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.id, for: indexPath) as? CategoriesCell else { return UITableViewCell()}
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128+8
    }
    
}

//MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCategory: [QuestionModel]
        
        switch indexPath.row {
        case 0: currentCategory = vKompaniiQuestions
        case 1: currentCategory = obmenOpitomQuestions
        case 2: currentCategory = vSebeQuestions
        case 3: currentCategory = naSvidaniiQuestions
        default: currentCategory = vKompaniiQuestions
        }
        
        
        let nextVC = CardViewController(with: categories[indexPath.row].title, questions: currentCategory )
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
