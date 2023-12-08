//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - SUBVIEWS
    
    private lazy var photosTitle: UILabel = {
       let photosTitle = UILabel()
        
        photosTitle.textColor = .black
        photosTitle.attributedText = .gilroySemiBold(string: "Photos", size: 20)
        
        photosTitle.translatesAutoresizingMaskIntoConstraints = false
        return photosTitle
    }()
    
    private lazy var photosArrow: UIImageView = {
        let photosArrow = UIImageView()
        
        let image = UIImage(
            systemName: "arrow.right")?.withTintColor(.black,renderingMode: .alwaysOriginal)
        photosArrow.image = image
        
        photosArrow.translatesAutoresizingMaskIntoConstraints = false
        return photosArrow
    }()
    
    private lazy var titleStackView: UIStackView = {
       let titleStackView = UIStackView()
        
        titleStackView.axis = .horizontal
        titleStackView.distribution = .equalSpacing
        titleStackView.alignment = .center
        
        titleStackView.addArrangedSubview(photosTitle)
        titleStackView.addArrangedSubview(photosArrow)
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        return titleStackView
    }()
    
    private lazy var photo1: UIImageView = {
        let photo1 = UIImageView()
        
        photo1.image = UIImage(named: "01")
        photo1.contentMode = .scaleAspectFill
        photo1.layer.cornerRadius = 6
        photo1.clipsToBounds = true
        
        photo1.translatesAutoresizingMaskIntoConstraints = false
        return photo1
    }()
    
    private lazy var photo2: UIImageView = {
        let photo2 = UIImageView()
        
        photo2.image = UIImage(named: "02")
        photo2.contentMode = .scaleAspectFill
        photo2.layer.cornerRadius = 6
        photo2.clipsToBounds = true
        
        photo2.translatesAutoresizingMaskIntoConstraints = false
        return photo2
    }()
    
    private lazy var photo3: UIImageView = {
        let photo3 = UIImageView()
        
        photo3.image = UIImage(named: "03")
        photo3.contentMode = .scaleAspectFill
        photo3.layer.cornerRadius = 6
        photo3.clipsToBounds = true
        
        photo3.translatesAutoresizingMaskIntoConstraints = false
        return photo3
    }()
    
    private lazy var photo4: UIImageView = {
        let photo4 = UIImageView()
        
        photo4.image = UIImage(named: "04")
        photo4.contentMode = .scaleAspectFill
        photo4.layer.cornerRadius = 6
        photo4.clipsToBounds = true
        
        photo4.translatesAutoresizingMaskIntoConstraints = false
        return photo4
    }()
    
    private lazy var photoStackView: UIStackView = {
        let photoStackView = UIStackView()
        
        photoStackView.axis = .horizontal
        photoStackView.distribution = .fillEqually
        photoStackView.alignment = .fill
        photoStackView.spacing = 8
        
        photoStackView.addArrangedSubview(photo1)
        photoStackView.addArrangedSubview(photo2)
        photoStackView.addArrangedSubview(photo3)
        photoStackView.addArrangedSubview(photo4)
        
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        return photoStackView
    }()

    // MARK: LIFECYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupSubview() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(photoStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            photoStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStackView.heightAnchor.constraint(equalToConstant: 91.5),
        ])
    }
    
}
