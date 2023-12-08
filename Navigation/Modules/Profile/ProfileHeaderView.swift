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
    
    var delegate: ProfileHeaderViewDelegate?
    
    private lazy var avatarImageView: UIImageView = {
        let photo = currentUser.avatar
        let avatarImageView = UIImageView(image: photo)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 55
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.attributedText = .gilroySemiBold(string: currentUser.fullName, size: 24)
        fullNameLabel.textColor = UIColor.black
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.attributedText = .gilroyRegular(string: currentUser.status, size: 16)
        statusLabel.textColor = UIColor.gray
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private lazy var setStatusButton: CustomButton = {
        let setStatusButton = CustomButton(action: buttonPressed, title: "Change Status", style: .secondary)
        return setStatusButton
    }()
    
    private lazy var addPostButton: CustomButton = {
        let setStatusButton = CustomButton(action: addPostButtonPressed, title: "Create Post", style: .primary)
        return setStatusButton
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.attributedPlaceholder = .gilroyRegular(string: "Say something...", size: 16)
        statusTextField.attributedText = .gilroyRegular(string: statusText, size: 16)
        statusTextField.textColor = .gray
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.lightGray.cgColor
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 10
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        return statusTextField
    }()
    
    private var statusText: String = ""
    
    // MARK: - LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        self.addSubview(avatarImageView)
        self.addSubview(setStatusButton)
        self.addSubview(addPostButton)
        self.addSubview(statusTextField)
        
        setupConstraints()
        setStatusButton.setup()
        addPostButton.setup()
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
    }
    
    @objc func signOut() {
        let keychain = KeychainService.shared.keychain
        keychain["isSignedIn"] = "false"
        
        let userService = CurrentUserService()
        let profileViewController = ProfileViewController()
        profileViewController.dismissSelf()
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        let innerStackView = UIStackView(arrangedSubviews: [fullNameLabel, signOutButton])
        innerStackView.axis = .horizontal
        innerStackView.distribution = .equalSpacing
        let stackView = UIStackView(arrangedSubviews: [innerStackView, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 10),
            setStatusButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            addPostButton.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 8),
            addPostButton.heightAnchor.constraint(equalToConstant: 40),
            addPostButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            addPostButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            addPostButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
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
    
    @objc private func addPostButtonPressed() {
        delegate?.createPostButtonPressed()
    }
    
    @objc private func signOutButtonPressed() {
        delegate?.signOutButtonPressed()
    }
}

protocol ProfileHeaderViewDelegate {
    func signOutButtonPressed()
    func createPostButtonPressed()
}
