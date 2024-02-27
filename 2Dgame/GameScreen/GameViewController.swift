//
//  GameViewController.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    private var gameSpeed: Speed = .easy
    private var buttonSpeedTimer: Timer?
    
    private let carImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenCar")
        image.frame = CGRect(x: (ScreenSize.width - .carWidth) / 2,
                             y: ScreenSize.height - .carHeight - .bottomInset,
                             width: .carWidth,
                             height: .carHeight)
        return image
    }()
    
    private lazy var leftButton: MoveCarButton = {
        let button = MoveCarButton(title: "←",
                                   frame: CGRect(x: .leftButtonInset,
                                                 y: ScreenSize.height - .moveManButtonHeight - .sideInset,
                                                 width: .moveManButtonWidth,
                                                 height: .moveManButtonHeight))
        return button
    }()
    
    private lazy var rightButton: MoveCarButton = {
        let button = MoveCarButton(title: "→",
                                   frame: CGRect(x: ScreenSize.width - .rightButtonInset,
                                                 y: ScreenSize.height - .moveManButtonHeight - .sideInset,
                                                 width: .moveManButtonWidth,
                                                 height: .moveManButtonHeight))
        return button
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: (ScreenSize.width - .scoreLabelWidth) / 2,
                             y: ScreenSize.height - .scoreLabelHeight - .leftButtonInset,
                             width: .scoreLabelWidth,
                             height: .scoreLabelHeight)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Score: \(score)"
        return label
    }()
    
    private let roadImageView: UIImageView = {
        let roadImage = UIImageView()
        roadImage.image = UIImage(named: "road")
        return roadImage
    }()
    
    private var score: Int = 0
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Functions
    
    private func setupViews() {
        roadImageView.frame  = view.bounds
        [roadImageView, carImageView, leftButton, rightButton, scoreLabel].forEach { view.addSubview($0) }
        
        leftButton.addTarget(self, action: #selector(leftLongPressedButton), for: .touchDown)
        leftButton.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        rightButton.addTarget(self, action: #selector(rightLongPressedButton), for: .touchDown)
        rightButton.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
    }
    
    //MARK: - @objc Functions
    
    @objc private func leftLongPressedButton() {
        buttonSpeedTimer = Timer.scheduledTimer(timeInterval: CGFloat.timeInterval, target: self, selector: #selector(moveViewLeft), userInfo: nil, repeats: true)
    }
    
    @objc private func rightLongPressedButton() {
        buttonSpeedTimer = Timer.scheduledTimer(timeInterval: CGFloat.timeInterval, target: self, selector: #selector(moveViewRight), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonReleased() {
        buttonSpeedTimer?.invalidate()
        buttonSpeedTimer = nil
    }
    
    @objc private func moveViewLeft() {
        guard carImageView.frame.origin.x > 0 else {
            return
        }
        carImageView.frame.origin.x -= 1
    }
    
    @objc private func moveViewRight() {
        guard carImageView.frame.maxX < view.bounds.width else {
            return
        }
        carImageView.frame.origin.x += 1
    }
}
