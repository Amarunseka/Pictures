//
//  ItemCollectionViewCell.swift
//  Pictures
//
//  Created by Миша on 09.03.2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var photoImage = UIImageView()
    var nameLabel = UILabel()
    private var containerView = UIView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        containerView.addSubview(photoImage)
        containerView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupNameLabel()
        setupConstraint()
    }
    
    private func setupImage(){
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleAspectFit
        photoImage.clipsToBounds = true
    }
    
    private func setupNameLabel(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .systemBlue
    }
    
    private func setupConstraint(){
        nameLabel.setContentHuggingPriority(.required, for: .vertical)

        let constraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            photoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            photoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
