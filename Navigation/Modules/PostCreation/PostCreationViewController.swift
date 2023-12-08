import UIKit

class PostCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: PostCreationDelegate?
    
    // MARK: - SUBVIEWS
    
    private lazy var postCreationTitle: UILabel = {
        let postCreationTitle = UILabel()
        
        postCreationTitle.textColor = .black
        postCreationTitle.attributedText = .gilroySemiBold(string: "Post Creation", size: 20)
        
        postCreationTitle.translatesAutoresizingMaskIntoConstraints = false
        return postCreationTitle
    }()
    
    private lazy var postTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Gilroy-Regular", size: 14)
        textView.textColor = UIColor.black
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var selectImageButton: CustomButton = {
        let button = CustomButton(action: selectImageButtonTapped, title: "Select Image", style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createPostButton: CustomButton = {
        let button = CustomButton(action: createPostButtonTapped, title: "Create Post", style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupSubviews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - SETUP METHODS
    
    private func setupSubviews() {
        view.addSubview(postCreationTitle)
        view.addSubview(postTextView)
        view.addSubview(imageView)
        view.addSubview(selectImageButton)
        view.addSubview(createPostButton)
        selectImageButton.setup()
        createPostButton.setup()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postCreationTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            postCreationTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postCreationTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            postTextView.topAnchor.constraint(equalTo: postCreationTitle.bottomAnchor, constant: 20),
            postTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            postTextView.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            selectImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            selectImageButton.heightAnchor.constraint(equalToConstant: 40),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createPostButton.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 20),
            createPostButton.heightAnchor.constraint(equalToConstant: 40),
            createPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Post Creation"
    }
    
    // MARK: - ACTION METHODS
    
    @objc private func createPostButtonTapped() {
        guard let image = imageView.image else { return }
        let post = PostModel(author: "Apple Inc.",
                             description: postTextView.text,
                             image: image,
                             likes: 0,
                             views: 1)
        var posts = [post]
        posts.append(contentsOf: PostModel.own)
        PostModel.own = posts
        delegate?.postCreated()
        dismiss(animated: true)
    }
    
    @objc private func selectImageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

protocol PostCreationDelegate {
    func postCreated()
}
