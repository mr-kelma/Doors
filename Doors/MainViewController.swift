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
        subscribeCustomViewAction()
        customView?.doorTable.delegate = self
        customView?.doorTable.dataSource = self
        loadTableView()
    }
    
    // MARK: - Methods
    
    private func subscribeCustomViewAction() {
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
        cell.configureCellWith(door: doorsData[indexPath.row], index: indexPath.row)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        let doorCondition = setUnlocking(index: indexPath.row)
        cell.changeCellCondition(doorCondition: doorCondition)
        cell.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let doorCondition = self.setUnlocked(index: indexPath.row)
            cell.changeCellCondition(doorCondition: doorCondition)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            let doorCondition = self.setLocked(index: indexPath.row)
            cell.changeCellCondition(doorCondition: doorCondition)
            cell.isUserInteractionEnabled = true
        }
    }
    
    func setUnlocking(index: Int) -> String {
        var door = doorsData[index]
        door.condition = .Unlocking
        doorsData[index].condition = .Unlocking
        return door.condition.rawValue
    }
    
    func setUnlocked(index: Int) -> String {
        var door = doorsData[index]
        door.condition = .Unlocked
        doorsData[index].condition = .Unlocked
        return door.condition.rawValue
    }
    
    func setLocked(index: Int) -> String {
        var door = doorsData[index]
        door.condition = .Locked
        doorsData[index].condition = .Locked
        return door.condition.rawValue
    }
}

// MARK: - Protocol: CustomTableViewCellDelegate

extension MainViewController: CustomTableViewCellDelegate {
    func handleDoorConditionLabelTapped(index: Int) {
        doorsData[index].condition = .Locked
    }
}
