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
        self.mainView.settingstableView.register(PromoCell.self, forCellReuseIdentifier: PromoCell.id)
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
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCell.id, for: indexPath) as? PromoCell else { return UITableViewCell()}
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.id, for: indexPath) as? SettingsCell else { return UITableViewCell()}
            cell.configure(setting: socialMedia[indexPath.row])
            return cell
        } else if indexPath.section == 2  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.id, for: indexPath) as? SettingsCell else { return UITableViewCell()}
            cell.configure(setting: otherSettings[indexPath.row])
            return cell
        }
       return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Мои соц. сети"
        } else if section == 2 {
            return "Другое"
        } else { return ""}
    }
    
    
}

extension SettingsViewController: PromoCellDelegate {
    
    func goToAccessScreen() {
        let accessVC = AccessViewController()
        accessVC.modalPresentationStyle = .pageSheet
        navigationController?.present(accessVC, animated: true)
    }
}
