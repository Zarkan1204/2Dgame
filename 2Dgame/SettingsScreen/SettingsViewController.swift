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
    
    private var nameLabel = UILabel(text: Constants.playerName, font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.placeholder
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = .cornerRadius
        textField.font = UIFont.systemFont(ofSize: .fontSize, weight: .regular)
        textField.textAlignment = .left
        textField.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
        let leftPaddingView = UIView(frame: CGRect(x: .zero, y: .zero, width: .leftPaddingWidth, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private var nameStackView = UIStackView()
    
    private var obstaclesLabel = UILabel(text: Constants.selectionObstacles, font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var yellowCarPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: Constants.yellowCar)
        imageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var redCarPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: Constants.redCar)
        imageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private var selectedImage: UIImageView?
    
    private var carStackView = UIStackView()
    private var obstaclesStackView = UIStackView()
    
    private var speedLabel = UILabel(text: Constants.gameSpeed, font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var speedSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: [Constants.easy,
                                                 Constants.medium,
                                                 Constants.hard])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self,
                          action: #selector(speedChanged),
                          for: .valueChanged)
        segment.backgroundColor = .systemGray5
        return segment
    }()
    
    private var avatarLabel = UILabel(text: Constants.chooseAvatar, font: .systemFont(ofSize: .fontSize), textColor: .black)
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = .userPhotoCornerRadius
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: Constants.plus)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseUserPhoto))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private var gameSpeed: Speed = .easy
    
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
    
    @objc private func speedChanged(sender: UISegmentedControl) {
        gameSpeed = SpeedManager.shared.setSpeed(sender: sender.selectedSegmentIndex)
        SpeedManager.shared.saveDifficulty(speed: gameSpeed)
    }
    
    @objc private func saveSettings() {
        guard let avatarImage = userPhotoImageView.image, let userName = nameTextfield.text, !userName.isEmpty else {
            return
        }
        let user = User(name: userName, avatar: avatarImage)
        StorageManager.shared.currentUser = user
        StorageManager.shared.saveAvatar(avatarImage, for: userName)
        StorageManager.shared.saveUsersData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func chooseUserPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let selectedImage = selectedImage {
            selectedImage.backgroundColor = .white
        }
        if let imageView = sender.view as? UIImageView {
            imageView.backgroundColor = .blue
            selectedImage = imageView
        }
    }

    //MARK: - Functions
    
    private func setupViews() {
        title = Constants.title
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.save, style: .plain, target: self, action: #selector(saveSettings))
        
        nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextfield], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(nameStackView)
        
        carStackView = UIStackView(arrangedSubviews: [redCarPicture, yellowCarPicture], axis: .horizontal, spacing: .stackSpacing)
        view.addSubview(carStackView)
        
        obstaclesStackView = UIStackView(arrangedSubviews: [obstaclesLabel, carStackView], axis: .vertical, spacing: CGFloat.stackSpacing)
        view.addSubview(obstaclesStackView)
        
        view.addSubview(speedSegment)
        
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
        
        redCarPicture.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.pictureWidth)
            make.height.equalTo(CGFloat.pictureHeight)
        }
        
        yellowCarPicture.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.pictureWidth)
            make.height.equalTo(CGFloat.pictureHeight)
        }
        
        speedSegment.snp.makeConstraints { make in
            make.top.equalTo(obstaclesStackView.snp.bottom).offset(CGFloat.segmentInset)
            make.leading.equalTo(view.snp.leading).offset(CGFloat.segmentInset)
            make.trailing.equalTo(view.snp.trailing).offset(-CGFloat.segmentInset)
            make.height.equalTo(CGFloat.segmentHeight)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.top.equalTo(speedSegment.snp.bottom).offset(CGFloat.topInset)
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

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        userPhotoImageView.image = image
        picker.dismiss(animated: true)
    }
}

//MARK: - Constants

private enum Constants {
    static let playerName = "Player name"
    static let placeholder = "enter your name"
    static let selectionObstacles = "Selection obstacles"
    static let yellowCar = "yellowCar"
    static let redCar = "redCar"
    static let gameSpeed = "Game speed"
    static let easy = "Easy"
    static let medium = "Medium"
    static let hard = "Hard"
    static let chooseAvatar = "Choose an avatar"
    static let plus = "plus"
    static let title = "Settings"
    static let save = "Save"
}

