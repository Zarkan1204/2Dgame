//
//  SpeedManager.swift
//  2Dgame
//
//  Created by Мой Macbook on 26.02.2024.
//

import Foundation

enum Speed: Double {
    case easy = 6.0
    case medium = 4.0
    case hard = 2.0
}

final class SpeedManager {
    
    static let shared = SpeedManager()
    private let speedKey = "selectedSpeed"
    
    private init() { }
    
    func setSpeed(sender: Int) -> Speed {
        switch sender {
        case 0:
            return .easy
        case 1:
            return .medium
        case 2:
            return .hard
        default:
            return .easy
        }
    }
    
    func saveDifficulty(speed: Speed) {
        UserDefaults.standard.set(speed.rawValue, forKey: speedKey)
    }
    
    func loadDifficulty() -> Speed {
        if let savedSpeed = UserDefaults.standard.value(forKey: speedKey) as? Double,
           let savedDifficulty = Speed(rawValue: savedSpeed) {
            return savedDifficulty
        }
        return .easy
    }
}
