//
//  MoveCarButton.swift
//  2Dgame
//
//  Created by Мой Macbook on 26.02.2024.
//

import UIKit

final class MoveCarButton: UIButton {

    //MARK: - Life Cycle
    
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        configureButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configureButton(title: String) {
        backgroundColor = .white
        layer.cornerRadius = .cornerRadius
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: .buttonfontSize, weight: .semibold)
    }
}
