//
//  CategoriesView.swift
//  Moment
//
//  Created by Gleb on 23.09.2023.
//

import UIKit
import SnapKit

class CategoriesView: UIView {
    
    //MARK: - Properties
    
    let categoriesTableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .insetGrouped)
        obj.rowHeight = UITableView.automaticDimension
        obj.backgroundColor = .clear
        obj.separatorStyle = .none
        return obj
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    
    private func setup() {
        
        
        
        addSubview(categoriesTableView)
        
        categoriesTableView.allowsSelection = true
        
        categoriesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    
    
}
