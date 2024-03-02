//
//  AlertGameCrash.swift
//  2Dgame
//
//  Created by Мой Macbook on 28.02.2024.
//

import UIKit

final class AlertGameCrash {
    
    static func showAlertGameCrash(withTitle title: String, message: String, restartAction: @escaping (() -> Void), exitAction: @escaping (() -> Void)) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let restart = UIAlertAction(title: Constants.restart, style: .default) { _ in
            restartAction()
        }
        let exit = UIAlertAction(title: Constants.exit, style: .destructive) { _ in
            exitAction()
        }
        
        alertController.addAction(restart)
        alertController.addAction(exit)
        return alertController
    }
}

private enum Constants {
    static let restart = "restart"
    static let exit = "Exit"
}
