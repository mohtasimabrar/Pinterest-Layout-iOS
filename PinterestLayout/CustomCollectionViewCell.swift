//
//  CustomCollectionViewCell.swift
//  PinterestLayout
//
//  Created by Mohtasim Abrar Samin on 20/6/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private lazy var imageViewHeightLayoutConstraint: NSLayoutConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 200)
    
    var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .darkGray
        
        return $0
    }(UIImageView())
    
    var labelView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGray
        
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(labelView)
        
        NSLayoutConstraint.activate([
            labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelView.heightAnchor.constraint(equalToConstant: 55),
            imageViewHeightLayoutConstraint,
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        imageViewHeightLayoutConstraint.isActive = false
        imageViewHeightLayoutConstraint = imageView.heightAnchor.constraint(equalToConstant: attributes.photoHeight)
        imageViewHeightLayoutConstraint.isActive = true
    }
}
