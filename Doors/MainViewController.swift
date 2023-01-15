//
//  MainController.swift
//  Doors
//
//  Created by Valery Keplin on 10.01.23.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let model = StorageModel.shared
    private var doorsData: [DoorModel] = []
    private lazy var customView = view as? MainView
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = MainView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewActions()
        customView?.doorTable.delegate = self
        customView?.doorTable.dataSource = self
        loadTableView()
    }
    
    // MARK: - Methods
    
    private func subscribeViewActions() {
        customView?.didPressedSettingButton = {
            print("Setting button was pressed")
        }
    }
    
    private func loadTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.doorsData = self.model.doors
            self.customView?.doorTable.reloadData()
            self.customView?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Protocols: UITableViewDelegate, UITableViewDataSource

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
