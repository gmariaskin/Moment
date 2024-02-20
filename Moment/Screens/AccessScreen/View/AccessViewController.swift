//
//  AccessViewController.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import RevenueCat


class AccessViewController: CustomViewController {
    
    //MARK: - Properties
    
    private let mainView = AccessView()
    
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
        setupButtons()
    }
    
    //MARK: - Actions
    
    func setupButtons() {
        
        Purchases.shared.getCustomerInfo {info, error in
            guard let info = info, error == nil else {return}
            
            if info.entitlements.all["Premium"]?.isActive == true {
                DispatchQueue.main.async {
                    print("User is premium")
                }
            }
            else {
                DispatchQueue.main.async {
                    self.mainView.freeTrialButton.isHidden = false
                    self.mainView.restorePurchaseButton.isHidden = false
                }
            }
        }
    }
    
    func fetchPackage1(completion: @escaping (RevenueCat.Package) -> Void) {
        
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else {return}
            
            offerings.all.forEach {
                print($0.value.availablePackages)
            }
            guard let package = offerings.all.first?.value.availablePackages.first else {return}
            
            completion(package)
        }
    }
    
    func fetchPackage2(completion: @escaping (RevenueCat.Package) -> Void) {
        
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else {return}
            
            offerings.all.forEach {
                print($0.value.availablePackages)
            }
            guard let package = offerings.all.first?.value.availablePackages.last else {return}
            
            completion(package)
        }
    }
    
    func purchase(package: RevenueCat.Package) {
        
        Purchases.shared.purchase(package: package) { transaction, info, error, userCanceled in
            guard let transaction = transaction,
                  let info = info,
                  error == nil,
                  !userCanceled else {return}
            self.dismiss(animated: true)
            
            print(info.entitlements)
        }
    }
    
    func restorePurchases() {
        Purchases.shared.restorePurchases { [weak self] info, error in
            guard let info = info, error == nil else {return}
            
            if info.entitlements.all["Premium"]?.isActive == true {
                DispatchQueue.main.async {
             
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.mainView.freeTrialButton.isHidden = false
                    self?.mainView.restorePurchaseButton.isHidden = false
                }
            }
        }
    }
    
    private func setup() {
        
        self.mainView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.mainView.price1.addTarget(self, action: #selector(price1tapped), for: .touchUpInside)
        self.mainView.price2.addTarget(self, action: #selector(price2tapped), for: .touchUpInside)
        self.mainView.freeTrialButton.addTarget(self, action: #selector(trialButtonTapped), for: .touchUpInside)
        self.mainView.restorePurchaseButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        self.mainView.termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.mainView.privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        
    }
    
    @objc private func termsTapped() {
        let guideVC = GuidelinesViewController(state: .termsOfUse)
        self.present(guideVC, animated: true)
    }
    
    @objc private func privacyTapped() {
        let guideVC = GuidelinesViewController(state: .privacyPolicy)
        self.present(guideVC, animated: true)
    }
    
    
    @objc private func price1tapped() {
        self.mainView.price1.configure(chosen: true)
        self.mainView.price1.isChosen = true
        self.mainView.price2.configure(chosen: false)
        self.mainView.price2.isChosen = false
    }
    
    @objc private func price2tapped() {
        self.mainView.price1.configure(chosen: false)
        self.mainView.price1.isChosen = false
        self.mainView.price2.configure(chosen: true)
        self.mainView.price2.isChosen = true
    }
    
    @objc private func trialButtonTapped() {
        let chosenPackage: RevenueCat.Package
        
           if mainView.price1.isChosen {
  
               fetchPackage1 { [weak self] package in
                   self?.purchase(package: package)
               }
           } else if mainView.price2.isChosen {
              
               fetchPackage2 { [weak self] package in
                   self?.purchase(package: package)
               }
           }
    }
    
    @objc private func restoreButtonTapped() {
    
        restorePurchases()
    }
    
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
    
}
