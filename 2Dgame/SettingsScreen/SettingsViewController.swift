//
//  SettingsViewController.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import SnapKit
import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var nameLabel = UILabel(text: "Player name", font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter your name"
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = .cornerRadius
        textField.font = UIFont.systemFont(ofSize: .fontSize, weight: .regular)
        textField.textAlignment = .left
        textField.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private var nameStackView = UIStackView()
    
    private var obstaclesLabel = UILabel(text: "Selection obstacles", font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private var yellowCarPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "yellowCar")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var redCarPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "redCar")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var carStackView = UIStackView()
    private var obstaclesStackView = UIStackView()
    
    private var speedLabel = UILabel(text: "Game speed", font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var lowSpeedButton = SpeedButtons(text: "Low")
    private lazy var midSpeedButton = SpeedButtons(text: "Mid")
    private lazy var hightSpeedButton = SpeedButtons(text: "Hight")
    
    private var buttonsSpeedStackView = UIStackView()
    private var speedStackView = UIStackView()
    
    private var avatarLabel = UILabel(text: "Choose an avatar", font: .systemFont(ofSize: .fontSize), textColor: .black)

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = .userPhotoCornerRadius
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
    }
    
    //MARK: - @objc Functions
    
    @objc private func textFieldShouldReturn() {
        view.endEditing(true)
    }
    
    @objc private func saveSettings() {
        print("save")
    }
    
    //MARK: - Functions
    
    private func setupViews() {
        title = "Settings"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSettings))
        
        nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextfield], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(nameStackView)
        
        carStackView = UIStackView(arrangedSubviews: [yellowCarPicture, redCarPicture], axis: .horizontal, spacing: .stackSpacing)
        view.addSubview(carStackView)
        
        obstaclesStackView = UIStackView(arrangedSubviews: [obstaclesLabel, carStackView], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(obstaclesStackView)
        
        buttonsSpeedStackView = UIStackView(arrangedSubviews: [lowSpeedButton, midSpeedButton, hightSpeedButton], axis: .horizontal, spacing: CGFloat.stackSpacing)
        view.addSubview(buttonsSpeedStackView)
        
        speedStackView = UIStackView(arrangedSubviews: [speedLabel, buttonsSpeedStackView], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(speedStackView)
        
        view.addSubview(avatarLabel)
        view.addSubview(userPhotoImageView)
    }
    
    private func setupLayout() {
        
        nameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.topInsetSuperview)
            make.left.equalToSuperview().offset(CGFloat.leftInset)
        }
        
        nameTextfield.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.textFieldWidth)
            make.height.equalTo(CGFloat.textFieldHeight)
        }
        
        obstaclesStackView.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(CGFloat.topInset)
            make.left.equalToSuperview().offset(CGFloat.leftInset)
        }
        
        yellowCarPicture.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.pictureWidth)
            make.height.equalTo(CGFloat.pictureHeight)
        }
        
        redCarPicture.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.pictureWidth)
            make.height.equalTo(CGFloat.pictureHeight)
        }
        
        speedStackView.snp.makeConstraints { make in
            make.top.equalTo(obstaclesStackView.snp.bottom).offset(CGFloat.topInset)
            make.left.equalToSuperview().offset(CGFloat.leftInset)
        }
        
        lowSpeedButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
        
        midSpeedButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
        
        hightSpeedButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.top.equalTo(speedStackView.snp.bottom).offset(CGFloat.topInset)
            make.left.equalToSuperview().offset(CGFloat.leftInset)
        }
        
        userPhotoImageView.snp.makeConstraints { make in
            make.top.equalTo(avatarLabel.snp.bottom).offset(CGFloat.topInset)
            make.left.equalToSuperview().offset(CGFloat.leftInset)
            make.width.equalTo(CGFloat.userPhotoWidth)
            make.height.equalTo(CGFloat.userPhotoHeight)
        }
    }
}
