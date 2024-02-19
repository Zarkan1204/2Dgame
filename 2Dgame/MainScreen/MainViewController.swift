//
//  MainViewController.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var startButton = MainButton(text: "START")
    private lazy var settingsButton = MainButton(text: "SETTINGS")
    private lazy var recordsButton = MainButton(text: "RECORDS")
    
    private var stackView = UIStackView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [startButton, settingsButton, recordsButton], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(stackView)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        recordsButton.addTarget(self, action: #selector(recordsButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Functions
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        startButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.mainButtonWidth)
            make.height.equalTo(CGFloat.mainButtonHeight)
        }

        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.mainButtonWidth)
            make.height.equalTo(CGFloat.mainButtonHeight)
        }
        
        recordsButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.mainButtonWidth)
            make.height.equalTo(CGFloat.mainButtonHeight)
        }
    }
    
    @objc private func startButtonTapped() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: false)
    }
    
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: false)
    }
    
    @objc private func recordsButtonTapped() {
        let scoreVC = ScoreViewController()
        navigationController?.pushViewController(scoreVC, animated: false)
    }
}
