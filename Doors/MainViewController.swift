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
    private let activityIndicator = UIActivityIndicatorView()
    
    private let doorTable : UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var doorsData: [Door] = []
    
    private lazy var welcomeLabel = setLabel(text: "Welcome", style: "Bold", size: 35)
    private lazy var myDoorsLabel = setLabel(text: "My doors", style: "Bold", size: 20)
    private lazy var settingButton = setButton(text: "imageSetting", action: #selector(pressedSetting))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(ciColor: .white)
        activityIndicator.startAnimating()
        doorTable.delegate = self
        doorTable.dataSource = self
        initialize()
        loadTableView()
    }
    
    // MARK: - Setups
    
    private func initialize() {
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
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(312)
            $0.left.equalTo(myDoorsLabel.snp.right).offset(8)
        }
        
        view.addSubview(doorTable)
        doorTable.snp.makeConstraints {
            $0.top.equalToSuperview().inset(360)
            $0.bottom.equalToSuperview().inset(40)
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    private func loadTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.doorsData = self.model.doors
            self.doorTable.reloadData()
            self.activityIndicator.stopAnimating()
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
    
    @objc private func pressedSetting() {
        print("The settings button was pressed")
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doorsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configureCellWith(door: doorsData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        var door = doorsData[indexPath.row]
        door.condition = .Unlocking
        doorsData[indexPath.row].condition = .Unlocking
        let doorCondition = door.condition.rawValue
        cell.changeCellCondition(doorCondition: doorCondition)
        cell.isUserInteractionEnabled = false

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            door.condition = .Unlocked
            self.doorsData[indexPath.row].condition = .Unlocked
            let doorCondition = door.condition.rawValue
            cell.changeCellCondition(doorCondition: doorCondition)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            door.condition = .Locked
            self.doorsData[indexPath.row].condition = .Locked
            let doorCondition = door.condition.rawValue
            cell.changeCellCondition(doorCondition: doorCondition)
            cell.isUserInteractionEnabled = true
        }
    }
}
