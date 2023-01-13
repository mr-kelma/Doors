//
//  CustomTableViewCell.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CustomTableViewCell"
    
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
    
    private lazy var container: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        return view
    }()
    
    private lazy var doorNameLabel = setLabel(text: "Front door", style: "Bold", size: 16, color: "darkBlueColor")
    private lazy var placeNameLabel = setLabel(text: "Home", style: "Regular", size: 14, color: "greyColor")
    private lazy var doorConditionLabel = setLabel(text: "Locked", style: "Bold", size: 15, color: "blueColor")
        
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    func configureCellWith(door: Door) {
        doorNameLabel.text = door.name
        placeNameLabel.text = door.place
        doorConditionLabel.text = door.condition.rawValue
        
        switch door.condition {
        case Condition.Locked:
            doorConditionLabel.textColor = UIColor(named: "blueColor")
        case Condition.Unlocking:
            doorConditionLabel.textColor = UIColor(named: "greyColor")
        default:
            doorConditionLabel.textColor = UIColor(named: "lightBlueColor")
        }
    }
    
    func changeCellCondition(door: Door) {
        print("Sending infomation about \(door.name) of \(door.place)")
        self.doorNameLabel.text = door.name
        self.placeNameLabel.text = door.place
        self.doorConditionLabel.text = "Unlocking..."
        self.doorConditionLabel.textColor = UIColor(named: "greyColor")
        self.leftIcon.image = UIImage(named: "leftIconUnlocking")
        self.rightIcon.image = UIImage(named: "iconLoadCircle")
        
        if self.rightIcon.image == UIImage(named: "iconLoadCircle") {
            rotateView(targetView: rightIcon)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.doorNameLabel.text = door.name
            self?.placeNameLabel.text = door.place
            self?.doorConditionLabel.text = "Unlocked"
            self?.doorConditionLabel.textColor = UIColor(named: "lightBlueColor")
            self?.leftIcon.image = UIImage(named: "leftIconUnlocked")
            self?.rightIcon.image = UIImage(named: "rightIconUnlocked")
            print("Infomation sent")
        }
    }
    
    private func setLabel(text: String, style: String, size: CGFloat, color: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.skModernist(style: style, size: size)
        label.textColor = UIColor(named: color)
        return label
    }
    
    private func initialize() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 36)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        container.addSubview(leftIcon)
        leftIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalToSuperview().offset(27)
        }
        
        container.addSubview(rightIcon)
        rightIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-28)
        }
        
        container.addSubview(doorNameLabel)
        doorNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.left.equalToSuperview().offset(82)
        }
        
        container.addSubview(placeNameLabel)
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.left.equalToSuperview().offset(82)
        }
        
        container.addSubview(doorConditionLabel)
        doorConditionLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Rotate mode

extension CustomTableViewCell {
    func rotateView(targetView: UIView, duration: Double = 1) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in self.rotateView(targetView: targetView, duration: duration)
        }
    }
}
