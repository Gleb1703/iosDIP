//
//  FeedViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    let coordinator: FeedCoordinator
    var feedViewModel = FeedViewModel()
    
    private enum CellReuse: String {
        case stories = "StoryCell"
        case post = "PostCell"
    }

    // MARK: - SUBVIEWS
    
    private let storiesCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 80, height: 100)
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: CellReuse.stories.rawValue)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()

        private let postsTableView: UITableView = {
            let tableView = UITableView()
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuse.post.rawValue)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
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
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        navigationItem.title = ""
        view.backgroundColor = .systemGray6
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    private func setupSubview() {
        view.addSubview(postsTableView)
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        postsTableView.backgroundColor = .systemGray6
        storiesCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        postsTableView.tableHeaderView = storiesCollectionView
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedViewModel.stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuse.stories.rawValue, for: indexPath) as! StoryCollectionViewCell
        cell.configure(with: feedViewModel.stories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stories = feedViewModel.stories[indexPath.row]
        let viewController = StoriesViewController()
        viewController.storiesModel = stories
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuse.post.rawValue, for: indexPath) as! PostTableViewCell
        let post = feedViewModel.posts[indexPath.row]
        cell.setup(with: post)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = feedViewModel.posts[indexPath.row]
        let viewController = PostViewController()
        viewController.post = post
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FeedViewController: PostViewDelegate {
    func likeButtonPressed(post: PostModel) {
        guard let index = feedViewModel.posts.firstIndex(where: { post.id == $0.id }) else { return }
        if post.liked {
            feedViewModel.posts[index].likes -= 1
        } else {
            feedViewModel.posts[index].likes += 1
        }
        feedViewModel.posts[index].liked.toggle()
        postsTableView.reloadData()
    }
}
