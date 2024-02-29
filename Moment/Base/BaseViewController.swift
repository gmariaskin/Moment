//
//  BaseViewController.swift
//  Moment
//
//  Created by DiOS on 29.02.2024.
//

import UIKit

class BasePremiumViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(premiumPurchased), name: .premiumPurchased, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(premiumExpired), name: .premiumExpired, object: nil)
    }

    @objc func premiumPurchased() {
    }

    @objc func premiumExpired() {
        
    }
}
