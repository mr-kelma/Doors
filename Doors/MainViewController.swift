//
//  ViewController.swift
//  Doors
//
//  Created by Valery Keplin on 10.01.23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private let model = DoorModel.shared
    private let topLabel = UIImageView(image: UIImage(named: "topLabel"))
    private let imageHomes = UIImageView(image: UIImage(named: "imageHomes"))
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var welcomeLabel = setLabel(text: "Welcome", style: "Bold", size: 35)
    private lazy var myDoorsLabel = setLabel(text: "My doors", style: "Bold", size: 20)
    private lazy var settingButton = settingButton(text: "imageSetting", action: #selector(pressedSetting))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Setups
    
    private func settingButton(text: String, action: Selector) -> UIButton {
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

    private func initialize() {
        view.backgroundColor = UIColor(ciColor: .white)
        
        tableView.backgroundColor = .clear
        
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.left.equalToSuperview().inset(24)
        }
        
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.right.equalToSuperview().inset(27)
        }
        
        view.addSubview(imageHomes)
        imageHomes.snp.makeConstraints {
            $0.top.equalToSuperview().inset(108)
            $0.right.equalToSuperview().inset(4)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(157)
            $0.left.equalToSuperview().inset(24)
        }
        
        view.addSubview(myDoorsLabel)
        myDoorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(307)
            $0.left.equalToSuperview().inset(24)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(360)
            $0.bottom.equalToSuperview().inset(40)
            $0.left.right.equalToSuperview().inset(15)
        }
    }

    //MARK: - Action
    
    @objc private func pressedSetting() {
        print("The settings button was pressed")
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("action after press cell")
    }
}
