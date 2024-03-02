//
//  GameViewController.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    private var gameSpeed: Speed = .easy
    private var score: Int = .zero
    private var buttonSpeedTimer: Timer?
    private var collisionTimer: Timer?
    
    private let carImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.greenCar)
        image.frame = CGRect(x: (ScreenSize.width - .carWidth) / CGFloat(Constants.two),
                             y: ScreenSize.height - .carHeight - .bottomInset,
                             width: .carWidth,
                             height: .carHeight)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var leftButton: MoveCarButton = {
        let button = MoveCarButton(title: Constants.left,
                                   frame: CGRect(x: .leftButtonInset,
                                                 y: ScreenSize.height - .moveManButtonHeight - .sideInset,
                                                 width: .moveManButtonWidth,
                                                 height: .moveManButtonHeight))
        return button
    }()
    
    private lazy var rightButton: MoveCarButton = {
        let button = MoveCarButton(title: Constants.right,
                                   frame: CGRect(x: ScreenSize.width - .rightButtonInset,
                                                 y: ScreenSize.height - .moveManButtonHeight - .sideInset,
                                                 width: .moveManButtonWidth,
                                                 height: .moveManButtonHeight))
        return button
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: (ScreenSize.width - .scoreLabelWidth) / CGFloat(Constants.two),
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
        roadImage.image = UIImage(named: Constants.road)
        return roadImage
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadSpeed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBarierCar()
    }
    
    //MARK: - Functions
    
    private func loadSpeed() {
        gameSpeed = SpeedManager.shared.loadDifficulty()
    }
    
    private func setupViews() {
        roadImageView.frame  = view.bounds
        [roadImageView, carImageView, leftButton, rightButton, scoreLabel].forEach { view.addSubview($0) }
        
        leftButton.addTarget(self, action: #selector(leftLongPressedButton), for: .touchDown)
        leftButton.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        rightButton.addTarget(self, action: #selector(rightLongPressedButton), for: .touchDown)
        rightButton.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
    }
    
    private func createBarierCar() -> UIImageView {
        let car = UIImageView()
        car.image = UIImage(named: Constants.redCar)
        let randomCarPosition = CGFloat(arc4random_uniform(UInt32(ScreenSize.width - .carHeight)))
        car.frame = CGRect(x: randomCarPosition,
                           y: -.carHeight - Constants.inset,
                           width: .carWidth,
                           height: .carHeight)
        car.contentMode = .scaleAspectFill
        return car
    }
    
    private func animateBarierCar() {
        collisionTimer?.invalidate()
        let car = createBarierCar()
        view.addSubview(car)
        view.bringSubviewToFront(car)
        
        UIView.animate(withDuration: gameSpeed.rawValue, animations: {
            car.frame.origin.y = ScreenSize.height + .carHeight
        }) { [weak self] _ in
            if car.layer.speed > .zero {
                if !(car.layer.presentation()?.frame.intersects(self?.carImageView.frame ?? CGRect.zero) == true) {
                }
                self?.animateBarierCar()
            }
        }
        
        collisionTimer = Timer.scheduledTimer(withTimeInterval: Constants.interval, repeats: true) { [weak self] _ in
            guard let self else { return }
            if car.layer.presentation()?.frame.intersects(self.carImageView.frame) == true {
                self.showAlert()
                self.collisionTimer?.invalidate()
                car.layer.speed = .zero
            }
        }
    }
    
    private func showAlert() {
        let alert = AlertGameCrash.showAlertGameCrash(withTitle: Constants.title, message: Constants.message,
                                                      restartAction: { self.restartGame() },
                                                      exitAction: { self.exitGame()})
        present(alert, animated: true)
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }
    
    private func restartGame() {
        collisionTimer?.invalidate()
        score = .zero
        updateScoreLabel()
        carImageView.frame.origin.x = (ScreenSize.width - .carWidth) / Constants.two
        carImageView.frame.origin.y = ScreenSize.height - .carHeight - .bottomInset
        animateBarierCar()
    }
    
    private func exitGame() {
        navigationController?.popViewController(animated: true)
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
        guard carImageView.frame.origin.x > .zero else {
            return
        }
        carImageView.frame.origin.x -= Constants.one
    }
    
    @objc private func moveViewRight() {
        guard carImageView.frame.maxX < view.bounds.width else {
            return
        }
        carImageView.frame.origin.x += Constants.one
    }
}

//MARK: - Constants

private enum Constants {
    static let inset: CGFloat = 20
    static let two: CGFloat = 2
    static let one: CGFloat = 1
    static let interval = 0.01
    static let greenCar = "greenCar"
    static let road = "road"
    static let redCar = "redCar"
    static let left = "←"
    static let right = "→"
    static let message = "You lost the game"
    static let title = "Game Over"
}
