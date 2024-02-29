//
//  SettingsViewController.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import StoreKit
import MessageUI


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
    }
    
    //MARK: - Actions
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print ("Can not send email")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["momentforquestion@gmail.com"])
        composer.setSubject("У меня проблема!")
        composer.setMessageBody("Привет, Вика!", isHTML: false)
        self.present(composer, animated: true)
    }
    
    
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
            case 0:
                print("Email Tapped")
                showMailComposer()
            case 1:
                let url = "https://apps.apple.com/app/id6474127030?action=write-review"
                guard let writeReviewURL = URL(string: url) else {
                    fatalError("Expected a valid URL")
                }
                UIApplication.shared.open(writeReviewURL)
            case 2:
                if let urlStr = NSURL(string: "https://apps.apple.com/us/app/id6474127030?ls=1&mt=8") {
                    let objectsToShare = [urlStr]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        if let popup = activityVC.popoverPresentationController {
                            popup.sourceView = self.view
                            popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                        }
                    }
                    self.present(activityVC, animated: true, completion: nil)
                }
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

//MARK: - Email Delegate

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        @unknown default:
            fatalError()
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
