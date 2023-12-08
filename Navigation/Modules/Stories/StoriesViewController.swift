import UIKit

class StoriesViewController: UIViewController {

    var storiesModel: StoriesModel?
    
    // MARK: - SUBVIEWS

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Gilroy-Bold", size: 20) ?? UIFont()
        ]
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Gilroy-Bold", size: 20) ?? UIFont()
        ]
        navigationController?.navigationBar.tintColor = UIColor.accentPrimary
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        if let author = storiesModel?.author {
            navigationItem.title = author
        }
    }
    
    private func setupSubview() {
        if let image = storiesModel?.image {
            imageView.image = image
        }
        view.addSubview(imageView)
        view.layer.addSublayer(createGradientLayer())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func createGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.6).cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
}
