//
//  CategoriesViewController.swift
//  Moment
//
//  Created by Gleb on 23.09.2023.
//

import UIKit
import rswift

class CategoriesViewController: CustomViewController {
    
    
    
    //MARK: - Properties
    
    private let mainView = CategoriesView()
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Actions
    
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
    
    [Category(title: "Мечты и амбиции", count: 120, description: "Желания и амбиции", color: R.color.color7()!, image: R.image.mechtiIcon()!),
     Category(title: "Хобби и интересы", count: 120, description: "Любимые занятия и\n увлечения", color: R.color.color6()!, image:  R.image.hobbiIcon()!),
     Category(title: "Путешествия", count: 120, description: "Лучшие места и планы на\n будущее", color: R.color.color3()!, image:  R.image.travelIcon()!),
     Category(title: "Ценности", count: 120, description: "Жизненные принципы и\n убеждения", color: R.color.color9()!, image:  R.image.valuesIcon()!),
     Category(title: "Семья", count: 120, description: "Родственники и традиции", color: R.color.color1()!, image: R.image.familyIcon()!)
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
        let nextVC = CardViewController(with: categories[indexPath.row].title )
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
