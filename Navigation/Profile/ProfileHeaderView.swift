//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

// MARK: - CONFIG

let userService = CurrentUserService()
let currentUser = userService.user

enum StatusError: Error {
    case emptyStatus
    case longStatus
}

class ProfileHeaderView: UIView {

    // MARK: - SUBVIEWS
        
    private lazy var avatarImageView: UIImageView = {
        let photo = currentUser.avatar
        let avatarImageView = UIImageView(image: photo)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = currentUser.fullName
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = UIColor.black
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = currentUser.status
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = UIColor.gray
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()

    private lazy var setStatusButton: CustomButton = {
        let setStatusButton = CustomButton(action: buttonPressed, color: .systemBlue, title: "Change Status", titleColor: .white)
        setStatusButton.layer.cornerRadius = 14
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOffset.width = 4
        setStatusButton.layer.shadowOffset.height = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        return setStatusButton
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.placeholder = "Say something..."
        statusTextField.textColor = .lightGray
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 12
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        return statusTextField
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var statusText: String = ""

    // MARK: - LIFECYCLE

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - PRIVATE METHODS

    private func setupView() {
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
//        self.addSubview(signOutButton)
        setupConstraints()
        setStatusButton.setup()
    }

    @objc func signOut() {
        let keychain = KeychainService.shared.keychain
        keychain["isSignedIn"] = "false"
        
        let userService = CurrentUserService()
//        let profileViewController = ProfileViewController(userService: userService, login: "")
        let profileViewController = ProfileViewController()
        profileViewController.dismissSelf()
    }

    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 125),
            avatarImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 125),

            fullNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 27),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            statusLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            statusLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -65),
            
            setStatusButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 185),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            statusTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),

//            signOutButton.heightAnchor.constraint(equalToConstant: 30),
//            signOutButton.widthAnchor.constraint(equalToConstant: 30),
//            signOutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
//            signOutButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
    }

    // MARK: - CATCHING STATUS ERROR

    private func checkStatus() throws {
        switch statusTextField.text?.count {
        case _ where statusTextField.text?.count == 0:
            throw StatusError.emptyStatus
        case _ where statusTextField.text!.count > 20:
            throw StatusError.longStatus
        default:
            statusLabel.text = statusTextField.text
            print("Status changed")
            statusTextField.text = nil
        }
    }

    func setStatus() {
        do {
            try checkStatus()
        } catch StatusError.emptyStatus {
            AlertModel.shared.showOkActionAlert(title: "Attention", message: "Status cannot be empty")
            print("Error: empty status")
        } catch StatusError.longStatus {
            AlertModel.shared.showOkActionAlert(title: "Attention", message: "Status cannot be longer than 20 characters")
            print("Error: too long status")
        } catch {
            print("Unknown error")
        }
    }

    // MARK: - ACTIONS

    @objc private func buttonPressed() {
        setStatus()
    }
}
