//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(gesture)
    }
    
    private func setupSubview() {
        self.addSubview(self.profileHeaderView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    @objc private func tap() {
        self.endEditing(true)
    }
}
