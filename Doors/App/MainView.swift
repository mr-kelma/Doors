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
        let padding: CGFloat = 20
        
        topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.leading.equalToSuperview().inset(padding)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.trailing.equalToSuperview().inset(padding)
        }
        
        imageHomes.snp.makeConstraints {
            $0.top.equalToSuperview().inset(108)
            $0.trailing.equalToSuperview().inset(4)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(157)
            $0.leading.equalToSuperview().inset(padding)
        }
        
        myDoorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(307)
            $0.leading.equalToSuperview().inset(padding)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(312)
            $0.leading.equalTo(myDoorsLabel.snp.trailing).offset(8)
        }
        
        doorTable.snp.makeConstraints {
            $0.top.equalToSuperview().inset(360)
            $0.bottom.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(15)
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
