//
//  SettingsFooterView.swift
//  Moment
//
//  Created by Gleb on 01.10.2023.
//

import UIKit

class SettingsFooterView: UIView {
    
    //MARK: - Properties
    
    private let label: UILabel = {
        let obj = UILabel()
        obj.text = "2023 Viktoria Belykh © All rights reserved"
        obj.font = R.font.sfProDisplayLight(size: 12)
        obj.textAlignment = .center
        obj.textColor = .lightGray
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
        
        addSubview(label)
        
        label.addCharacterSpacing(kernValue: 2)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    
    
    
    
    
}
