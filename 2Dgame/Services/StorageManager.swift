//
//  StorageManager.swift
//  2Dgame
//
//  Created by Мой Macbook on 07.03.2024.
//

import UIKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    var currentUser: User?
    var users: [User] = []
    
    private init() {
        getCurrentUser()
    }
    
    func getCurrentUser() {
        if currentUser == nil {
            currentUser = User(name: .name)
        }
    }
    
    func saveCurrentUser() {
        if let user = currentUser {
            users.append(user)
        }
    }
    
    func saveAvatar(_ image: UIImage, for name: String) {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(name).png")
        if let data = image.pngData() {
            try? data.write(to: url)
        }
    }
    
    func loadAvatar(name: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = directory.appendingPathComponent(name)
        return UIImage(contentsOfFile: url.path)
    }
    
    func saveUsersData() {
            DispatchQueue.main.async { [weak self] in
                UserDefaults.standard.saveUsers(self?.users ?? [])
                for user in self?.users ?? [] {
                    if let avatar = user.avatar {
                        self?.saveAvatar(avatar, for: user.name)
                    }
                }
            }
        }
    
    func loadUsersData() {
        if let loadedUsers = UserDefaults.standard.loadUsers() {
                self.users = loadedUsers
                for (index, user) in loadedUsers.enumerated() {
                    self.users[index].avatar = self.loadAvatar(name: user.name)
                }
            }
        }
}

private extension String {
    static let key = "key"
    static let name = "Player"
}

extension UserDefaults {
    
    func saveUsers(_ users: [User]) {
        let data = try? JSONEncoder().encode(users)
        UserDefaults.standard.setValue(data, forKey: .key)
    }
    
    func loadUsers() -> [User]? {
        guard let data = data(forKey: .key) else { return nil }
        if let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        } else {
            return nil
        }
    }
}
