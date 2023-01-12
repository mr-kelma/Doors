//
//  CustomTableViewCell.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // MARK: Property
    
    static let identifier = "CustomTableViewCell"
    
    //MARK: - UIElements
    
    // IMAGES
    private let leftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftIconLocked")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightIconLocked")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // LABELS
    private func setLabel(text: String, size: CGFloat, color: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.customFont(size: size)
        label.textColor = UIColor(named: color)
        return label
    }
    
    private lazy var frontDoorLabel = setLabel(text: "Front Door", size: 16, color: "darkBlueColor")
    private lazy var placeNameLabel = setLabel(text: "Home", size: 14, color: "greyColor")
    private lazy var doorConditionLabel = setLabel(text: "Locked", size: 15, color: "BlueColor")
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setups
    
    private func initialize() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(leftIcon)
        leftIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-58)
            $0.left.equalToSuperview().offset(27)
        }
        
        contentView.addSubview(rightIcon)
        rightIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-54)
            $0.right.equalToSuperview().offset(-28)
        }
        
        contentView.addSubview(frontDoorLabel)
        frontDoorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.left.equalToSuperview().offset(82)
        }
        
        contentView.addSubview(placeNameLabel)
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.left.equalToSuperview().offset(82)
        }
        
        contentView.addSubview(doorConditionLabel)
        doorConditionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.center.equalToSuperview()
        }
    }
}
