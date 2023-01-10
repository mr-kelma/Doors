//
//  ViewController.swift
//  Doors
//
//  Created by Valery Keplin on 10.01.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: Property
    
    //MARK: - UIElements
    
    private let imageHomes = UIImage(named: "imageHomes")
    private let topLabel = UIImage(named: "topLabel")
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    
    //MARK: - Setups
    
    private func initialize() {
        view.backgroundColor = UIColor(ciColor: .white)
        
        let imageHomes = UIImageView(image: imageHomes)
        let topLabel = UIImageView(image: topLabel)
        
        view.addSubview(imageHomes)
        imageHomes.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(120)
            maker.right.equalToSuperview().inset(15)
        }
        
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(100)
            maker.left.equalToSuperview().inset(15)
        }
    }
    
    //MARK: - Action
    
    @objc private func pressedSetting() {
        print("The settings button was pressed")
    }
    
}
