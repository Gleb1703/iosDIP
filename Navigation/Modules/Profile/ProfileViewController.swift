//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - DATA
    
    fileprivate lazy var data = PostModel.own
    
    // MARK: - SUBVIEWS
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableView_ReuseID"
        case photos = "PhotosTableView_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        tuneTableView()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photos.rawValue)
        
        tableView.register(
            ProfileTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    public func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: HeaderFooterReuseID.base.rawValue
            ) as? ProfileTableHeaderView else {
                fatalError("could not dequeueReusableCell")
            }
            headerView.profileHeaderView.delegate = self
            return headerView
        } else {
            let emptyHeader = UIView()
            return emptyHeader
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let nextViewController = PhotosViewController()
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(
                nextViewController,
                animated: true
            )
            break
        case 1:
            let post = data[indexPath.row]
            let viewController = PostViewController()
            viewController.post = post
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
            break
        default:
            break
        }
    }
}

// MARK: - TableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photos.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath)
                as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        let data = data[indexPath.row]
        cell.setup(with: data)
        cell.delegate = self
        return cell
    }
}

// MARK: - Drag & Drop Delegate

extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let image = self.data[indexPath.row].image
        let imageProvider = NSItemProvider(object: image as UIImage)
        
        let description = self.data[indexPath.row].description
        let descriptionProvider = NSItemProvider(object: description as NSString)
        
        let dragImage = UIDragItem(itemProvider: imageProvider)
        dragImage.localObject = image
        
        let dragDescription = UIDragItem(itemProvider: descriptionProvider)
        dragDescription.localObject = description
        
        return [dragImage, dragDescription]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: String.self) { items in
            
            guard let strings = items as? [String] else { return }
            
            guard let postDescr = strings.first else { return }
            
            guard let imageUrl: URL = URL(string: strings[1]) else { return }
            
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    let postImage = UIImage(data: data)
                    
                    let newPost = PostModel(author: "Drag&Drop", description: postDescr, image: postImage ?? UIImage(named: "steve")!, likes: 0, views: 0)
                    
                    var indexPaths = [IndexPath]()
                    
                    let indexPath = IndexPath(row: destinationIndexPath.row, section: destinationIndexPath.section)
                    self.data.insert(newPost, at: indexPath.row)
                    indexPaths.append(indexPath)
                    tableView.insertRows(at: indexPaths, with: .automatic)
                }
            }
            .resume()
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: String.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func createPostButtonPressed() {
        let postCreationVC = PostCreationViewController()
        postCreationVC.delegate = self
        self.present(postCreationVC, animated: true, completion: nil)
    }
    
    func signOutButtonPressed() {
        let keychain = KeychainService.shared.keychain
        keychain["isSignedIn"] = "false"
        
        navigationController?.popViewController(animated: true)
    }
}


extension ProfileViewController: PostViewDelegate {
    func likeButtonPressed(post: PostModel) {
        guard let index = data.firstIndex(where: { post.id == $0.id }) else { return }
        if post.liked {
            data[index].likes -= 1
        } else {
            data[index].likes += 1
        }
        data[index].liked.toggle()
        tableView.reloadData()
    }
}

extension ProfileViewController: PostCreationDelegate {
    func postCreated() {
        data = PostModel.own
        tableView.reloadData()
    }
}
