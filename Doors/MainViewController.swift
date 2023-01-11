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
    
    // LABELS
    private let imageHomes = UIImageView(image: UIImage(named: "imageHomes"))
    private let topLabel = UIImageView(image: UIImage(named: "topLabel"))
    
    private func setLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.customFont(size: size)
        return label
    }
    private lazy var welcomeLabel = setLabel(text: "Welcome", size: 35)
    private lazy var myDoorsLabel = setLabel(text: "My doors", size: 20)
    
    // BUTTON
    private func settingButton(text: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: text), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private lazy var settingButton = settingButton(text: "labelSetting", action: #selector(pressedSetting))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Setups
    
    private func initialize() {
        view.backgroundColor = UIColor(ciColor: .white)

        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(77)
            maker.left.equalToSuperview().inset(24)
        }
        
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(63)
            maker.right.equalToSuperview().inset(27)
        }
        
        view.addSubview(imageHomes)
        imageHomes.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(108)
            maker.right.equalToSuperview().inset(4)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(157)
            maker.left.equalToSuperview().inset(24)
        }
        
        view.addSubview(myDoorsLabel)
        myDoorsLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(307)
            maker.left.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - Action
    
    @objc private func pressedSetting() {
        print("The settings button was pressed")
    }
}
