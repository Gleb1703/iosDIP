//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - SUBVIEWS
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 1
        authorLabel.textColor = .systemGray
        return authorLabel
    }()
    
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        return postImage
    }()
    
    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.textColor = .black
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.numberOfLines = 4
        return postDescription
    }()
    
    private lazy var numberOfLikesLabel: UILabel = {
        let numberOfLikes = UILabel()
        numberOfLikes.translatesAutoresizingMaskIntoConstraints = false
        numberOfLikes.textColor = .systemGray
        return numberOfLikes
    }()
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "heart")?.withTintColor(.accentPrimary, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var numberOfViewsLabel: UILabel = {
        let numberOfViews = UILabel()
        numberOfViews.translatesAutoresizingMaskIntoConstraints = false
        numberOfViews.textColor = .lightGray
        return numberOfViews
    }()
    
    private lazy var viewsImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "eye")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = true
        let likesStackView = UIStackView()
        likesStackView.clipsToBounds = true
        let viewsStackView = UIStackView()
        viewsStackView.clipsToBounds = true
        
        likesStackView.axis = .horizontal
        likesStackView.alignment = .bottom
        likesStackView.spacing = 4

        viewsStackView.axis = .horizontal
        viewsStackView.alignment = .bottom
        viewsStackView.spacing = 4

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        likesStackView.addArrangedSubview(likeImageView)
        likesStackView.addArrangedSubview(numberOfLikesLabel)
        viewsStackView.addArrangedSubview(viewsImageView)
        viewsStackView.addArrangedSubview(numberOfViewsLabel)
        
        stackView.addArrangedSubview(likesStackView)
        stackView.addArrangedSubview(viewsStackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var aspectRatioConstraint: NSLayoutConstraint?
    
    // MARK: - LIFECYCLE
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        contentView.clipsToBounds = true
    }
    
    private func setupSubview() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -12),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            viewsImageView.heightAnchor.constraint(equalToConstant: 17),
            viewsImageView.widthAnchor.constraint(equalToConstant: 17),
        ])
    }
    
    private func updateAspectRatioConstraint() {
        if let existingConstraint = aspectRatioConstraint {
            postImage.removeConstraint(existingConstraint)
        }
        let aspectRatio = (postImage.image?.size.height ?? 1) / (postImage.image?.size.width ?? 1)
        aspectRatioConstraint = postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: aspectRatio)
        aspectRatioConstraint?.isActive = true
    }

    
    // MARK: - PUBLIC METHODS
    
    func setup(with post: PostModel) {
        authorLabel.attributedText = .gilroySemiBold(string: post.author, size: 18)
        postImage.image = post.image
        postDescription.attributedText = .gilroyRegular(string: post.description, size: 16, lineSpacing: 5)
        
        numberOfViewsLabel.attributedText = .gilroySemiBold(string: String(post.views), size: 16)
        numberOfLikesLabel.attributedText = .gilroySemiBold(string: String(post.likes), size: 16)
        updateAspectRatioConstraint()
    }
}
