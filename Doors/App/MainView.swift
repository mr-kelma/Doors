//
//  MainView.swift
//  Doors
//
//  Created by Valery Keplin on 14.01.23.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Properties
    
    var didPressedSettingButton: (() -> Void)?
    
    let doorTable: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView()
    
    private let topLabel = UIImageView(image: UIImage(named: C.Images.topLabel))
    private let imageHomes = UIImageView(image: UIImage(named: C.Images.homes))
    
    private lazy var settingButton = setButton(text: C.Images.setting, action: #selector(pressedSetting))
    private lazy var welcomeLabel = setLabel(text: C.Labels.welcome, style: FontWeight.bold.rawValue, size: 35)
    private lazy var myDoorsLabel = setLabel(text: C.Labels.myDoors, style: FontWeight.bold.rawValue, size: 20)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(ciColor: .white)
        activityIndicator.startAnimating()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        addSubview(topLabel)
        addSubview(settingButton)
        addSubview(imageHomes)
        addSubview(welcomeLabel)
        addSubview(myDoorsLabel)
        addSubview(activityIndicator)
        addSubview(doorTable)
    }
    
    func makeConstraints() {
        let sidePadding: CGFloat = 20
        let sidePaddingForTable: CGFloat = 20
        
        topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.leading.equalToSuperview().inset(sidePadding)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.trailing.equalToSuperview().inset(sidePadding)
        }
        
        imageHomes.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(63)
            $0.leading.equalToSuperview().inset(sidePadding)
        }
        
        myDoorsLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(115)
            $0.leading.equalToSuperview().inset(sidePadding)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(118)
            $0.leading.equalTo(myDoorsLabel.snp.trailing).offset(8)
        }
        
        doorTable.snp.makeConstraints {
            $0.top.equalTo(myDoorsLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(sidePaddingForTable)
        }
    }
    
    private func setButton(text: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: text), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func setLabel(text: String, style: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.skModernist(style: style, size: size)
        return label
    }
    
    //MARK: - Action
    
    @objc func pressedSetting() {
        didPressedSettingButton?()
    }
}
