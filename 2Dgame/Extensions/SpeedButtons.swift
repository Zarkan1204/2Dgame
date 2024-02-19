//
//  SpeedButtons.swift
//  2Dgame
//
//  Created by Мой Macbook on 16.02.2024.
//

import Foundation

import UIKit

class SpeedButtons: UIButton {
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        backgroundColor = .systemGray
        titleLabel?.font = .systemFont(ofSize: .fontSize)
        tintColor = .white
        layer.cornerRadius = .speedButtonRadius
    }
}

