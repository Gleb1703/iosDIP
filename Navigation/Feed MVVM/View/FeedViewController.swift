//
//  FeedViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    var post = Post(title: "My Post")

    let coordinator: FeedCoordinator

    var feedViewModel = FeedViewModel()

    // MARK: - SUBVIEWS

    private lazy var showPostButton1 = CustomButton(action: buttonAction, color: .yellow, title: "Show Post #1", titleColor: .black)

    private lazy var showPostButton2 = CustomButton(action: buttonAction, color: .green, title: "Show Post #2", titleColor: .black)

    private lazy var checkTextField: UITextField = {
        let checkTextField = UITextField()
        checkTextField.placeholder = " Password"
        checkTextField.textColor = .lightGray
        checkTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        checkTextField.layer.borderWidth = 1
        checkTextField.layer.borderColor = UIColor.black.cgColor
        checkTextField.backgroundColor = .white
        checkTextField.layer.cornerRadius = 12
        checkTextField.translatesAutoresizingMaskIntoConstraints = false
        return checkTextField
    }()

    private lazy var checkGuessButton = CustomButton(action: check, color: .systemOrange, title: "Check Password", titleColor: .black)

    lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.backgroundColor = .white
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 15
        resultLabel.textAlignment = .center

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(self.showPostButton1)
        stackView.addArrangedSubview(self.showPostButton2)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - INIT

    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        tabBarController?.tabBar.backgroundColor = .systemGray6

        view.addSubview(stackView)
        view.addSubview(checkTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)

        setupConstraints()
        showPostButton1.setup()
        showPostButton2.setup()
        checkGuessButton.setup()
        bindViewModel()
    }

    // MARK: - LAYOUT

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            checkTextField.heightAnchor.constraint(equalToConstant: 40),
            checkTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            checkTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            checkTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),

            checkGuessButton.topAnchor.constraint(equalTo: checkTextField.bottomAnchor, constant: 20),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),

            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
            resultLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 30),
            resultLabel.widthAnchor.constraint(equalToConstant: 30),
        ])
    }

    // MARK: - ACTIONS

    func bindViewModel() {
        feedViewModel.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.resultLabel.text = statusText
            }
        })

        feedViewModel.statusColor.bind({ (statusColor) in
            DispatchQueue.main.async {
                self.resultLabel.backgroundColor = statusColor
            }
        })
    }
    
    func openPost() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func buttonAction() {
            openPost()
        }

    @objc func check() {
        feedViewModel.buttonPressed(word: (checkTextField.text ?? ""))
    }
}
