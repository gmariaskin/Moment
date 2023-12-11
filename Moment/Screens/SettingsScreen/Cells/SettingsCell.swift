//
//  SettingsCell.swift
//  Moment
//
//  Created by Gleb on 25.09.2023.
//

import UIKit

class SettingsCell: UITableViewCell {

    //MARK: - Properties

    static let id = String(describing: SettingsCell.self)
    
    private let icon : UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .center
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.font = R.font.sfProDisplayLight(size: 16)
        obj.numberOfLines = 2
        obj.textColor = .black
        return obj
    }()
    
    private let arrow : UIImageView = {
        let obj = UIImageView()
        obj.image = R.image.rightArrow()
        return obj
    }()
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = .white
        
        addSubview(icon)
        addSubview(nameLabel)
        addSubview(arrow)
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(12)
            make.trailing.equalTo(arrow.snp.leading)
        }
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
            make.size.equalTo(24)
        }
    }
    
    func configureWithSocialMedia(setting: socialMediaModel) {
        self.icon.image = setting.image
        self.nameLabel.text = setting.name
        nameLabel.addCharacterSpacing(kernValue: 2)
    }
    
    func configureWithSettings(setting: settingModel) {
        self.icon.image = setting.image
        self.nameLabel.text = setting.name
        nameLabel.addCharacterSpacing(kernValue: 2)
    }
    
}
