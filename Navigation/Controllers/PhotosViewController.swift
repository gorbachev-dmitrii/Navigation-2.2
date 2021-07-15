//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 15.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    var images = [UIImage]()
    var noirImages = [UIImage]()
    let facade = ImagePublisherFacade()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "myWhite")
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .white
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.isHidden = false
        setupConstraints()
        // подписываем себя на изменения
        facade.subscribe(self)
        // добавляем изображения по таймеру
        //facade.addImagesWithTimer(time: 5, repeat: 10)
        for i in 1...20 {
            images.append(UIImage(named: "\(i)")!)
        }
        qosBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        facade.removeSubscription(for: self)
    }
    
    func qosBackground() {
        ImageProcessor().processImagesOnThread(sourceImages: images, filter: .noir, qos: .background) { (newImages) in
            for image in newImages {
                self.noirImages.append(UIImage(cgImage: image!))
            }
        }
        collectionView.reloadData()
    }
    
    func qosUserInitiated() {
        ImageProcessor().processImagesOnThread(sourceImages: images, filter: .noir, qos: .userInitiated) { (images) in

        }
    }
    
    func qosUserInteractive() {
        ImageProcessor().processImagesOnThread(sourceImages: images, filter: .noir, qos: .userInteractive) { (images) in

        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.images = images
        collectionView.reloadData()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noirImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.imageView.image = noirImages[indexPath.item]
        return cell
    }

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // первое *2 - отступ слева и справа для секции, второе *2 - два отступа между cell
        let width: CGFloat = (collectionView.bounds.width - 8 * 2 * 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
