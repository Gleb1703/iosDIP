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
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.numberOfLines = 2
        authorLabel.textColor = .black
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
        postDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescription.textColor = .systemGray
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.numberOfLines = 0
        return postDescription
    }()
    
    private lazy var numberOfLikes: UILabel = {
        let numberOfLikes = UILabel()
        numberOfLikes.translatesAutoresizingMaskIntoConstraints = false
        numberOfLikes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfLikes.textColor = .black
        return numberOfLikes
    }()
    
    private lazy var numberOfViews: UILabel = {
        let numberOfViews = UILabel()
        numberOfViews.translatesAutoresizingMaskIntoConstraints = false
        numberOfViews.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfViews.textColor = .black
        return numberOfViews
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(numberOfLikes)
        stackView.addArrangedSubview(numberOfViews)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        contentView.backgroundColor = .white
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
            postImage.bottomAnchor.constraint(equalTo: postDescription.topAnchor, constant: -16),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - PUBLIC METHODS
    
    func setup(with post: PostModel) {
        authorLabel.text = post.author
        postImage.image = post.image
        postDescription.text = post.description
        numberOfViews.text = String("Views: \(post.views)")
        numberOfLikes.text = String("Likes: \(post.likes)")
    }
}
