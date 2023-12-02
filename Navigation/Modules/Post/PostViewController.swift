import UIKit

class PostViewController: UIViewController {

    var post: PostModel?

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
        postDescription.numberOfLines = 0
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupConstraints()

        if let post = post {
            setup(with: post)
        }
    }

    private func setupView() {
        view.backgroundColor = .white
        self.navigationItem.title = post?.author ?? "Anonymous"
    }

    private func setupSubviews() {
        view.addSubview(postImage)
        view.addSubview(stackView)
        view.addSubview(postDescription)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
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

    private func setup(with post: PostModel) {
        postImage.image = post.image
        postDescription.attributedText = .gilroyRegular(string: post.description, size: 16, lineSpacing: 5)
        numberOfViewsLabel.attributedText = .gilroySemiBold(string: String(post.views), size: 16)
        numberOfLikesLabel.attributedText = .gilroySemiBold(string: String(post.likes), size: 16)
        updateAspectRatioConstraint()
    }
}
