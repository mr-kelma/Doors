//
//  CustomTableViewCell.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func handleDoorConditionLabelTapped(index: Int)
}

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = C.identifier
    
    var cellIndex: Int?
    
    weak var delegate: CustomTableViewCellDelegate?
    
    private let leftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: C.Icons.leftLocked)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: C.Icons.rightLocked)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let iconLoadCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: C.Icons.loadCircle)
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
    
    private lazy var doorNameLabel = setLabel(text: C.Labels.frontDoor, style: FontWeight.bold.rawValue, size: 16, color: C.Colors.darkBlueColor)
    private lazy var placeNameLabel = setLabel(text: C.Labels.home, style: FontWeight.regular.rawValue, size: 14, color: C.Colors.greyColor)
    private lazy var doorConditionLabel = setLabel(text: Condition.Locked.rawValue, style: FontWeight.bold.rawValue, size: 15, color: C.Colors.blueColor)
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupLabelTap()
        setupSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureCellWith(door: DoorModel, index: Int) {
        cellIndex = index
        doorNameLabel.text = door.name
        placeNameLabel.text = door.place
        doorConditionLabel.text = door.condition.rawValue
        
        switch door.condition {
        case Condition.Locked:
            doorConditionLabel.textColor = UIColor(named: C.Colors.blueColor)
        case Condition.Unlocking:
            doorConditionLabel.textColor = UIColor(named: C.Colors.greyColor)
        default:
            doorConditionLabel.textColor = UIColor(named: C.Colors.lightBlueColor)
        }
    }
    
    func changeCellCondition(doorCondition: String) {
        switch doorCondition {
        case Condition.Unlocked.rawValue:
            self.doorConditionLabel.text = Condition.Unlocked.rawValue
            self.doorConditionLabel.textColor = UIColor(named: C.Colors.lightBlueColor)
            self.leftIcon.image = UIImage(named: C.Icons.leftUnlocked)
            self.rightIcon.image = UIImage(named: C.Icons.righUnlocked)
            removeIndicator()
        case Condition.Unlocking.rawValue:
            self.doorConditionLabel.text = Condition.Unlocking.rawValue+"..."
            self.doorConditionLabel.textColor = UIColor(named: C.Colors.greyColor)
            self.leftIcon.image = UIImage(named: C.Icons.leftUnlocking)
            unlockingDoor()
            rotateView(targetView: iconLoadCircle, rotationPeriod: 1)
        default:
            self.doorConditionLabel.text = Condition.Locked.rawValue
            self.doorConditionLabel.textColor = UIColor(named: C.Colors.blueColor)
            self.leftIcon.image = UIImage(named: C.Icons.leftLocked)
            self.rightIcon.image = UIImage(named: C.Icons.rightLocked)
        }
    }
    
    private func setLabel(text: String, style: String, size: CGFloat, color: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.skModernist(style: style, size: size)
        label.textColor = UIColor(named: color)
        return label
    }
    
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.conditionLabelTapped(_:)))
        doorConditionLabel.isUserInteractionEnabled = true
        doorConditionLabel.addGestureRecognizer(labelTap)
    }
    
    private func unlockingDoor() {
        rightIcon.alpha = 0
        container.addSubview(iconLoadCircle)
        iconLoadCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-30)
            $0.height.width.equalTo(25)
        }
    }
    
    private func removeIndicator() {
        rightIcon.alpha = 1
        iconLoadCircle.removeFromSuperview()
    }
    
    private func setupSubviews() {
        contentView.addSubview(container)
        container.addSubview(leftIcon)
        container.addSubview(rightIcon)
        container.addSubview(doorNameLabel)
        container.addSubview(placeNameLabel)
        container.addSubview(doorConditionLabel)
    }
    
    private func makeConstraints() {
        let sidePaddingInCell: CGFloat = 27
        let tablePadding: CGFloat = 20
        let topPaddingInCell: CGFloat = 20
        
        container.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - tablePadding * 2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        leftIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topPaddingInCell)
            $0.leading.equalToSuperview().offset(sidePaddingInCell)
        }
        
        rightIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topPaddingInCell)
            $0.trailing.equalToSuperview().offset(-sidePaddingInCell)
        }
        
        doorNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topPaddingInCell)
            $0.leading.equalTo(leftIcon.snp.trailing).offset(14)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(doorNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(leftIcon.snp.trailing).offset(14)
        }
        
        doorConditionLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Action
    
    @objc func conditionLabelTapped(_ sender: UITapGestureRecognizer) {
        delegate?.handleDoorConditionLabelTapped(index: cellIndex ?? 0)
        changeCellCondition(doorCondition: Condition.Unlocking.rawValue)
        doorConditionLabel.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.changeCellCondition(doorCondition: Condition.Unlocked.rawValue)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.changeCellCondition(doorCondition: Condition.Locked.rawValue)
            self.doorConditionLabel.isUserInteractionEnabled = true
            self.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Rotate Mode

extension CustomTableViewCell {
    func rotateView(targetView: UIView, rotationPeriod: Double) {
        for _ in 1...3 {
            let period = rotationPeriod * 3
            UIView.animate(withDuration: period, delay: 0, options: .curveLinear, animations: {
                targetView.transform = targetView.transform.rotated(by: .pi)
            }, completion: nil)
        }
    }
}
