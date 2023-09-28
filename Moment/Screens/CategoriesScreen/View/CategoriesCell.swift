//
//  CategoriesTableViewCell.swift
//  Moment
//
//  Created by Gleb on 23.09.2023.
//

import UIKit

class CategoriesCell: UITableViewCell {
    //MARK: - Properties
    
    static let id = String(describing: CategoriesCell.self)
    
    let containerView: UIView = {
        let obj = UIView()
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.font = R.font.sfProDisplayRegular(size: 20)
    
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .gray
        obj.numberOfLines = 2
        obj.font = R.font.sfProDisplayLight(size: 12)
        return obj
    }()
    
    private let countLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .gray
        obj.font = R.font.sfProDisplayLight(size: 14)
        return obj
    }()
    
    private let image : UIImageView = {
        let obj = UIImageView()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 16
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        layoutSubviews()
        addSubview(containerView)
        contentView.addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(countLabel)
        containerView.clipsToBounds = true
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(image.snp.leading).inset(16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.bottom.equalToSuperview().inset(16)
        }
        
        image.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.size.equalTo(120)
        }
        
        descriptionLabel.numberOfLines = 2
      
    }
    
    func configure(with category: Category) {
        self.nameLabel.text = category.title
        self.descriptionLabel.text = category.description
        self.countLabel.text = "\(category.count) шт"
        self.image.image = category.image
        self.containerView.backgroundColor = category.color
        self.nameLabel.addCharacterSpacing(kernValue: 2)
        self.descriptionLabel.addCharacterSpacing(kernValue: 2)
        self.countLabel.addCharacterSpacing(kernValue: 2)
    }
}
