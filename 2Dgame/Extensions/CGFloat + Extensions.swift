//
//  CGFloat + Extensions.swift
//  2Dgame
//
//  Created by Мой Macbook on 14.02.2024.
//

import UIKit

extension CGFloat {
    
    //MainVC
    static let mainButtonHeight = 100
    static let mainButtonWidth = 250
    static let buttonfontSize: CGFloat = 22
    
    //General
    static let stackSpacing: CGFloat = 15
    static let cornerRadius: CGFloat = 16
    static let fontSize: CGFloat = 16
    
    //SettingsVC
    static let labelWidth = 200
    static let labelHeight = 40
    
    static let textFieldWidth = 300
    static let textFieldHeight = 40
    
    static let leftInset: CGFloat = 20
    static let topInsetSuperview: CGFloat = 100
    static let topInset: CGFloat = 20
    
    static let pictureWidth = 80
    static let pictureHeight = 100
    static let speedButtonRadius: CGFloat = 10
    
    static let buttonWidth = 60
    static let buttonHeight = 60
    
    static let userPhotoWidth = 100
    static let userPhotoHeight = 100
    
    static let userPhotoCornerRadius: CGFloat = 50
    static let segmentInset: CGFloat = 16
    static let segmentHeight = 40
    static let leftPaddingWidth: CGFloat = 10
    
    //ScoreVC
    static let scoreFontSize: CGFloat = 22
    static let scoreHeight: CGFloat = 40
    static let scoreInsert: CGFloat = 8
    static let rowHeight: CGFloat = 50
    
    //GameVC
    static let carStep: CGFloat = 25
    static let carHeight: CGFloat = 80
    static let carWidth: CGFloat = 80
    static let bottomInset: CGFloat = 130
    
    static let moveManButtonWidth: CGFloat = 80
    static let moveManButtonHeight: CGFloat = 40
    static let leftButtonInset: CGFloat = 20
    static let rightButtonInset: CGFloat = 100
    static let sideInset: CGFloat = 30
    
    static let scoreLabelWidth: CGFloat = 150
    static let scoreLabelHeight: CGFloat = 30
    
    static let timeInterval = 0.003
    static let minimumScaleFactor = 0.5
}

enum ScreenSize {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}
