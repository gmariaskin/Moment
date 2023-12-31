//
//  SettingsViewController.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import StoreKit

class SettingsViewController: CustomViewController {
    
    //MARK: - Properties
    
    private let mainView = SettingsView()
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var questions: [CDQuestion]?
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
   //     fetchQuestions()
    }
    
    //MARK: - Actions
    
//    func fetchQuestions() {
//        do {
//            self.questions =  try context.fetch(CDQuestion.fetchRequest())
//            print(questions)
//        }
//        catch {
//            
//        }
//    }
    
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
    
    private let socialMedia: [socialMediaModel] = [
        
        socialMediaModel(image: R.image.globe()!, name: "Сайт", url: "https://viktoriyabelykh.com"),
        socialMediaModel(image: R.image.instagram()!, name: "Instagram", url: "https://www.instagram.com/viktoriya.belll/"),
        socialMediaModel(image: R.image.telegram()!, name: "Telegram", url: "https://t.me/vwiktoriya")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1 :
            guard let url = URL(string: socialMedia[indexPath.row].url) else { return }
            UIApplication.shared.open(url)
        case 2 :
            switch indexPath.row {
            case 3 : 
                let guideVC = GuidelinesViewController(state: .privacyPolicy)
                self.navigationController?.pushViewController(guideVC, animated: true)
            case 4: 
                let guideVC = GuidelinesViewController(state: .termsOfUse)
                self.navigationController?.pushViewController(guideVC, animated: true)
            default:
                break
            }
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
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
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.id, for: indexPath) as? SettingsCell else { return UITableViewCell()}
            cell.configureWithSocialMedia(setting: socialMedia[indexPath.row])
            cell.selectionStyle = .default
            return cell
        } else if indexPath.section == 2  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.id, for: indexPath) as? SettingsCell else { return UITableViewCell()}
            cell.configureWithSettings(setting: otherSettings[indexPath.row])
            cell.selectionStyle = .default
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return SettingsFooterView()
        } else {
            return UITableViewHeaderFooterView()
        }
    }
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 40
}



extension SettingsViewController: PromoCellDelegate {
    
    func goToAccessScreen() {
        let accessVC = AccessViewController()
        accessVC.modalPresentationStyle = .pageSheet
        navigationController?.present(accessVC, animated: true)
    }
}
