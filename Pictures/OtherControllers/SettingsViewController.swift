//
//  SettingsViewController.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - initialise Elements
    private let isSortedLabel = SpecialNameLabel(text: "Sorting")
    
    private let isSortedSwitch: UISwitch = {
        let isSortedSwitch = UISwitch()
        isSortedSwitch.addTarget(self, action: #selector(isSortedSwitchChange), for: .valueChanged)
        return isSortedSwitch
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Ascending", "Descending"])
        segmentedControl.backgroundColor = .gray
        segmentedControl.isEnabled = isSortedSwitch.isOn
        segmentedControl.addTarget(self, action: #selector(isSortedSegmentChange), for: .valueChanged)
        return segmentedControl
    }()
    
    private let changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHANGE PASSWORD", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - Private Methods
    private func setupViews(){
        view.backgroundColor = .systemGray3
        title = "Settings"
        [isSortedLabel, isSortedSwitch, segmentedControl, changePasswordButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let sortingModel = SortingBehaviorManager.shared.sortingModel
        isSortedSwitch.isOn = sortingModel.isSorting
        segmentedControl.isEnabled = isSortedSwitch.isOn
        segmentedControl.selectedSegmentIndex = sortingModel.sortingMode
    }
    
    @objc
    private func isSortedSwitchChange(paramTarget: UISwitch){
        segmentedControl.isEnabled = paramTarget.isOn
        saveSortingModel(isSorting: paramTarget.isOn, sortingMode: segmentedControl.selectedSegmentIndex)
    }
    
    @objc
    private func isSortedSegmentChange(paramTarget: UISegmentedControl){
        saveSortingModel(isSorting: isSortedSwitch.isOn, sortingMode: paramTarget.selectedSegmentIndex)
    }
    
    @objc
    private func changePasswordButtonTapped(){
        let vm = ChangePasswordViewModel()
        let vc = LoginViewController(viewModel: vm)
        present(vc, animated: true)
    }
    
    private func saveSortingModel(isSorting: Bool, sortingMode: Int){
        let sortingModel = SortingModel(isSorting: isSorting, sortingMode: sortingMode)
        UserDefaultsManager.saveSortingData(data: sortingModel)
    }
}

// MARK: - Constraints
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            isSortedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            isSortedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            isSortedSwitch.topAnchor.constraint(equalTo: isSortedLabel.bottomAnchor, constant: 3),
            isSortedSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            segmentedControl.topAnchor.constraint(equalTo: isSortedSwitch.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            changePasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            changePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
