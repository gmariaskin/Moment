//
//  AccessViewController.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

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
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        self.mainView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.mainView.price1.addTarget(self, action: #selector(price1tapped), for: .touchUpInside)
        self.mainView.price1.addTarget(self, action: #selector(price2tapped), for: .touchUpInside)
        
    }
    
    @objc private func price1tapped() {
        
    }
    
    @objc private func price2tapped() {
        
    }
  
    @objc private func close() {
        self.dismiss(animated: true)
    }

}
