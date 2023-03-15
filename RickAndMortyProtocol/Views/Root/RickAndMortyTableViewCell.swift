//
//  RickAndMortyTableViewCell.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 12.03.2023.
//

import UIKit
import Kingfisher

class RickAndMortyTableViewCell: UITableViewCell {

    var characterImageView = UIImageView()
    var characterNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        configureImageView()
        configureNameLabel()
        setImageConstraints()
        setNameLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character : Characters){
        characterNameLabel.text = character.name
        characterImageView.kf.setImage(with: URL(string: character.image))
    }
    
    func configureImageView(){
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
        
    }
    
    func configureNameLabel(){
        characterNameLabel.numberOfLines = 0
        characterNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints(){
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor).isActive = true
    }
    
    func setNameLabelConstraints(){
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    
    
}

