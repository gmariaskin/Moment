//
//  CustomViewController.swift
//  Moment
//
//  Created by Gleb on 24.09.2023.
//

import UIKit
import rswift

class CustomViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupBackground()
    }
    
    //MARK: - Actions
    
    private func setupBackground() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let whiteBg = UIImageView(frame: UIScreen.main.bounds)
        
        backgroundImage.image = R.image.background()
        backgroundImage.layer.opacity = 0.8
        backgroundImage.contentMode = .scaleAspectFill
        
        whiteBg.backgroundColor = .white
        
        self.view.insertSubview(whiteBg, at: 0)
        self.view.insertSubview(backgroundImage, at: 1)
    }
    
    private func setupNav() {
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: R.font.sfProDisplayLight(size: 28) ?? .systemFont(ofSize: 28),
                .foregroundColor: UIColor.black,
                .kern: 2
            ]
            navigationBar.titleTextAttributes = textAttributes
        }
    }
    
    
}
