//
//  GameManager.swift
//  2Dgame
//
//  Created by Мой Macbook on 07.03.2024.
//

import Foundation

final class GameManager {
    
    static let shared = GameManager()
    
    var currentUser: User?
    var users: [User] = []
    
    private init() {}
}
