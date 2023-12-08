//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit
import iOSIntPackage
import Foundation

class PhotosViewController: UIViewController {
    
    let imageProcessor = ImageProcessor()

    // MARK: - PROPERTIES

    private lazy var photoCollection: [UIImage] = []
    private lazy var photoCollectionProcessed: [UIImage] = []
    
    // MARK: - SUBVIEWS
    
    private enum CollectionCellReuseID: String {
        case base = "CollectionCellReuseID_ReuseID"
    }
    
    private let collectionView: UICollectionView = {
        let viewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewFlowLayout
        )
        
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionCellReuseID.base.rawValue
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        measure()
    }
    
    // MARK: - PRIVATE METHODS

    private func measure() {
        photoCollection = PhotoModel.photoLabel
        let group = DispatchGroup()
        group.enter()
        let start = CFAbsoluteTimeGetCurrent()
        imageProcessor.processImagesOnThread(sourceImages: photoCollection, filter: .noir, qos: .default) { [self] completion in
            for photoFromCollection in completion {
            if let photo = photoFromCollection {
                photoCollectionProcessed.append(UIImage(cgImage: photo))
            }
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
            print("Processing has taken \(diff) seconds")
            group.leave()
        }

        group.notify(queue: .main) { [self] in
            photoCollection = photoCollectionProcessed
            collectionView.reloadData()
        }
        
        /*
         Результаты
         .default = 5.52 seconds
         .userInitiated = 5.64 seconds
         .userInteractive = 5.18 seconds
         .utility = 19.37 seconds
         .background = 52.34 seconds
         */
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery"
    }
    
    private func setupSubview() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
        ])
    }
}

// MARK: - UICollectionView DataSource / Delegate

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photoCollection.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCellReuseID.base.rawValue,
            for: indexPath
        ) as? PhotosCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }

        let photo = photoCollection[indexPath.row]
        cell.setup(with: photo)
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * 8 + (itemsInRow - 1) * 8
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: 8
        )
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 8,
            left: 8,
            bottom: 8,
            right: 8)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
}
