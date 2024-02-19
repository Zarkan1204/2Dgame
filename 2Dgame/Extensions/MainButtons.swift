//
//  MainButtons.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import Foundation

import UIKit

class MainButton: UIButton {
    
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
        backgroundColor = .systemBlue
        titleLabel?.font = .systemFont(ofSize: .buttonfontSize, weight: .semibold)
        tintColor = .white
        layer.cornerRadius = .cornerRadius
    }
}
