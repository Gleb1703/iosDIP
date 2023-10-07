//
//  PostViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class PostViewController: UIViewController {

    var titlePost: String = "Anonymous"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        self.navigationItem.title = titlePost
        
        let infoButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(showInfo))
        
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func showInfo() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
    
}
