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
    
    private let roadImageView: UIImageView = {
        let roadImage = UIImageView()
        roadImage.image = UIImage(named: Constants.road)
        return roadImage
    }()
    
    private lazy var startButton = MainButton(text: Constants.start)
    private lazy var settingsButton = MainButton(text: Constants.settings)
    private lazy var recordsButton = MainButton(text: Constants.records)
    
    private var stackView = UIStackView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        roadImageView.frame  = view.bounds
        view.addSubview(roadImageView)
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

private enum Constants {
    static let road = "road"
    static let start = "START"
    static let settings = "SETTINGS"
    static let records = "RECORDS"
}
