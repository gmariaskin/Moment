//
//  SettingsViewController.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

class SettingsViewController: CustomViewController {
    
    //MARK: - Properties
    
    private let mainView = SettingsView()
    
    
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        self.title = "Настройки"
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem(image: R.image.backButton(), style: .plain, target: self, action: #selector(backToCategories))
        self.navigationItem.leftBarButtonItem = backItem
        
        self.mainView.settingstableView.dataSource = self
        self.mainView.settingstableView.delegate = self
        self.mainView.settingstableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.id)
        
        self.mainView.unlockCardsButton.addTarget(self, action: #selector(goToAccessScreen), for: .touchUpInside)
        
        
    }
    
    @objc private func goToAccessScreen() {
       let accessVC = AccessViewController()
        accessVC.modalPresentationStyle = .pageSheet
        self.navigationController?.present(accessVC, animated: true)
    }
    
    @objc private func backToCategories() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Model

    private let socialMedia: [settingModel] = [
        
        settingModel(image: R.image.globe()!, name: "Сайт"),
        settingModel(image: R.image.instagram()!, name: "Instagram"),
        settingModel(image: R.image.telegram()!, name: "Telegram")
    ]
    
    private let otherSettings: [settingModel] = [
        settingModel(image: R.image.support()!, name: "Поддержка"),
        settingModel(image: R.image.rate()!, name: "Оценить приложение"),
        settingModel(image: R.image.share()!, name: "Рассказать о приложении"),
        settingModel(image: R.image.privacy()!, name: "Политика конфиденциальности"),
        settingModel(image: R.image.terms()!, name: "Условия пользования")
        
    ]
    
    
    
    
    
    
    
}


extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return socialMedia.count
        } else {
            return otherSettings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.id, for: indexPath) as? SettingsCell else { return UITableViewCell()}
        if indexPath.section == 0 {
            cell.configure(setting: socialMedia[indexPath.row])
        } else {
            cell.configure(setting: otherSettings[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Мои соц. сети"
        } else {
            return "Другое"
        }
    }
    
    
}
