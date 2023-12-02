//
//  LogInViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit
//import FirebaseAuth

class LogInViewController: UIViewController {
    
// MARK: - SUBVIEWS

//    let service = Service()
//    var users = [Credentials]()
//
//    var credentials = [Credentials]()

    var password: String = ""

    var loginDelegate: LoginViewControllerDelegate?

    let coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImage(named: "logo")
        let logoImage = UIImageView(image: image)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    private lazy var loginTextField: UITextField = { [unowned self] in
        let loginTextField = UITextField()
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        loginTextField.placeholder = "Email or phone"
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.textColor = .black
        loginTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginTextField.tintColor = UIColor(named: "AccentColor")
        loginTextField.autocapitalizationType = .none
        loginTextField.backgroundColor = .systemGray6
        
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.layer.borderWidth = 0.5
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.autocorrectionType = .no
        loginTextField.keyboardType = .namePhonePad
        
        loginTextField.delegate = self
        
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = { [unowned self] in
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.placeholder = "Password"
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .systemGray6
        
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.delegate = self
        
        return passwordTextField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.alignment = .fill
        stackView.spacing = -0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        passwordTextField.addSubview(hackIndicator)
        
        return stackView
    }()

    private lazy var logInButton: CustomButton = {
        let logInButton = CustomButton(
            action: loginButtonPressed,
            title: "Log In",
            style: .primary,
            textSize: 20
        )
        logInButton.layer.cornerRadius = 10

        return logInButton
    }()

    private lazy var hackPasswordButton: CustomButton = {
        let hackPasswordButton = CustomButton(
            action: hack,
            title: "Hack Password",
            style: .danger,
            textSize: 20
        )
        hackPasswordButton.layer.cornerRadius = 10

        return hackPasswordButton
    }()

    private lazy var hackIndicator: UIActivityIndicatorView = {
        let hackIndicator = UIActivityIndicatorView()
        hackIndicator.hidesWhenStopped = true
        hackIndicator.style = UIActivityIndicatorView.Style.medium

        hackIndicator.translatesAutoresizingMaskIntoConstraints = false
        return hackIndicator
    }()

    private lazy var loginIndicator: UIActivityIndicatorView = {
        let loginIndicator = UIActivityIndicatorView()
        loginIndicator.hidesWhenStopped = true
        loginIndicator.style = UIActivityIndicatorView.Style.medium

        loginIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loginIndicator
    }()
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        logInButton.setup()
        hackPasswordButton.setup()
        checkAuth()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        
        setupKeyboardObservers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openProfile), name: Notification.Name("Login successful"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
        removeKeyboardObservers()
    }
    
    // MARK: - LAYOUT
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.addSubview(logoImage)
        contentView.addSubview(logInButton)
        logInButton.addSubview(loginIndicator)
        contentView.addSubview(hackPasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            hackPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            hackPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            hackPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hackPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hackPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            hackIndicator.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            hackIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),

            loginIndicator.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            loginIndicator.centerYAnchor.constraint(equalTo: logInButton.centerYAnchor)
        ])
    }

    // MARK: - Keyboard

    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
    
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyBoard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

    @objc func willShowKeyBoard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        guard scrollView.contentInset.bottom < keyboardHeight else { return }

        scrollView.contentInset.bottom += keyboardHeight
        scrollView.scrollRectToVisible(logInButton.frame, animated: true)
    }

    @objc  func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }

    // MARK: - Hack Password

    private func bruteForce(passwordToUnlock: String) {
        let bruteForce = BruteForce()
        let allowedCharacters: [String] = String().printable.map { String($0) }
        while password != passwordToUnlock {
            password = bruteForce.generateBruteForce(password, fromArray: allowedCharacters)
        }
    }

    @objc private func hack() {
        func randomString(length: Int) -> String {
            let symbols = String().printable
            return String((0..<length).map {_ in symbols.randomElement()! })
        }

        let queue = DispatchQueue.global(qos: .userInitiated)
        let group = DispatchGroup()

        group.enter()
        self.passwordTextField.text = nil
        self.passwordTextField.placeholder = nil
        self.hackIndicator.startAnimating()
        self.hackPasswordButton.backgroundColor = .systemGray
        self.hackPasswordButton.titleLabel?.textColor = .systemGray2
        self.hackPasswordButton.isEnabled = false
        queue.async {
            self.bruteForce(passwordToUnlock: randomString(length: 4))
            group.leave()
        }
        group.notify(queue: .main) { [self] in
            self.passwordTextField.isSecureTextEntry = false
            self.passwordTextField.text = password
            self.hackIndicator.stopAnimating()
            self.hackPasswordButton.backgroundColor = .systemPink
            self.hackPasswordButton.titleLabel?.textColor = .white
            self.hackPasswordButton.isEnabled = true
        }
    }

    // MARK: - Log In

    @objc private func loginButtonPressed() {
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            AlertModel.shared.showOkActionAlert(title: "Attention", message: "Email and password cannot be empty")
            return
        }
//        guard loginDelegate?.check(email: email, password: password) == true else {
//            return
//        }
        checkAuth() // для пропуска авторизации
    }

    @objc func openProfile() {
//        let currentUserService = CurrentUserService()
//        let vc = ProfileViewController(userService: currentUserService, login: loginTextField.text!)
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func checkAuth() {
        let keychain = KeychainService.shared.keychain
        keychain["isSignedIn"] = "true" // для пропуска авторизации
        if keychain["isSignedIn"] == "true" {
            openProfile()
        }
    }
}

// MARK: - EXTENSIONS

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension UIColor {
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        let lengh = hexSanitized.count
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {return nil}
        
        if lengh == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if lengh == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
