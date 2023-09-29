//
//  SettingsView.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    //MARK: - Properties

    let settingstableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .insetGrouped)
        obj.rowHeight = UITableView.automaticDimension
        obj.backgroundColor = .clear
        obj.separatorStyle = .singleLine
        obj.isScrollEnabled = true
        return obj
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        addSubview(settingstableView)
        
        settingstableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        
    }
    
    
}
