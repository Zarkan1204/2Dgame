//
//  ScoreTableViewCell.swift
//  2Dgame
//
//  Created by Мой Macbook on 19.02.2024.
//

import SnapKit
import UIKit

final class ScoreTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var avatarImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.layer.cornerRadius = CGFloat.cornerRadius
        image.backgroundColor = .blue
        image.clipsToBounds = true
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: .scoreFontSize)
        return label
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: .scoreFontSize)
        return label
    }()
    
    private let backView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    //MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    //MARK: - Functions
    
    func configure(with user: User) {
        avatarImageView.image = user.avatar
        nameLabel.text = user.name
        scoreLabel.text = "\(user.score)"
    }
    
    private func setupViews() {
        backgroundColor = .white
        [backView, avatarImageView, nameLabel, scoreLabel].forEach {contentView.addSubview($0)}
    }
    
    private func setupLayout() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.scoreInsert)
            make.height.equalTo(CGFloat.scoreHeight)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(backView)
            make.size.equalTo(CGFloat.scoreHeight)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(backView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(CGFloat.scoreInsert)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(backView)
            make.leading.equalTo(nameLabel.snp.trailing).offset(CGFloat.scoreInsert)
            make.trailing.equalTo(backView).offset(-CGFloat.scoreInsert)
        }
    }
}



