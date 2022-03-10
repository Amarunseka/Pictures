//
//  CollectionViewController.swift
//  Pictures
//
//  Created by Миша on 09.03.2022.
//

import UIKit

class CollectionViewController: UIViewController {

    // MARK: - collection view
    private let indentBetweenItems: CGFloat = 8
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    
    // MARK: - file manager
    private let fileManager = FileManager.default
    private var currentDirectoryURL: URL
    private var content: [URL] = []

    
    
    // MARK: - execution
    init(directoryURL:URL) {
        self.currentDirectoryURL = directoryURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupFileManager()
    }
    
    private func setupNavigationBar(){
        let add = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createFolder))
        
        let image = UIBarButtonItem(
            barButtonSystemItem: .camera,
            target: self,
            action: #selector(savePicture))
        
        navigationItem.rightBarButtonItems = [add, image]
        navigationController?.navigationBar.scrollEdgeAppearance =
        navigationController?.navigationBar.standardAppearance
    }

    
    
    // MARK: - setups
    private func setupCollectionView(){
        view.addSubview(collectionView)
        view.addGestureRecognizer(gesture)
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemGray3
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func setupFileManager(){
        
        self.content = try! fileManager.contentsOfDirectory(
            at: currentDirectoryURL,
            includingPropertiesForKeys: nil,
            options: [])
    }
    
    
    // MARK: - actions
    @objc private func createFolder(){
        let alert = CreateNewFolderAlert()
        
        alert.showAlert(vc: self, parentURL: currentDirectoryURL) { [weak self] result in
            if result {
                self?.setupFileManager()
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func savePicture(){
        chooseImagePicker(source: .photoLibrary)
    }
}




// MARK: - CollectionView

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        content.sort(by: {
            $0.path.count < $1.path.count
        })
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ItemCollectionViewCell.self),
            for: indexPath) as! ItemCollectionViewCell
        
        
        let itemURL = content[indexPath.item]
        
        cell.nameLabel.text = itemURL.lastPathComponent
        
        let type = try! fileManager.attributesOfItem(atPath: (itemURL.path))
        
        if type[.type] as! FileAttributeType == FileAttributeType.typeDirectory {
            cell.photoImage.image = UIImage(systemName: "folder.fill")
            cell.nameLabel.text = itemURL.lastPathComponent
        } else {
            cell.photoImage.image = UIImage(contentsOfFile: itemURL.path)
            cell.nameLabel.text = "Photo \(indexPath.row)"
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sideSize = CGFloat((collectionView.frame.width - indentBetweenItems * 4) / 3)
        
        return CGSize(width: sideSize, height: sideSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return indentBetweenItems
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return indentBetweenItems
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: indentBetweenItems,
            left: indentBetweenItems,
            bottom: indentBetweenItems,
            right: indentBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = content[indexPath.item]
        let type = try! fileManager.attributesOfItem(atPath: (url.path))
        
        if type[.type] as! FileAttributeType == FileAttributeType.typeDirectory {
            let vc = CollectionViewController(directoryURL: url)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = PhotoViewController()
            vc.imageView.image = UIImage(contentsOfFile: url.path)
            present(vc, animated: true)
        }
    }
}

// MARK: - ImagePicker

extension CollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            let photo = info[.originalImage] as! UIImage
            let data = photo.pngData()
            let photoURL = info[.imageURL] as! URL
            let photoName = photoURL.lastPathComponent
            
            let pathToPhoto = currentDirectoryURL.appendingPathComponent("Photo - \(photoName)")

            fileManager.createFile(
                atPath: pathToPhoto.path,
                contents: data,
                attributes: nil)
            content.append(pathToPhoto)
            collectionView.reloadData()
            dismiss(animated: true)
    }
}

// MARK: - Delete
extension CollectionViewController {
    private var gesture: UISwipeGestureRecognizer {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        gesture.direction = .left
        gesture.numberOfTouchesRequired = 1
        return gesture
    }
    
    @objc private func swipe(_ gesture: UISwipeGestureRecognizer){
        let gestureLocation = gesture.location(in: collectionView)
        let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation)
        let alert = DeleteItemAlert()
        
        if let itemIndex = targetIndexPath?.row {
            alert.showDeleteAlert(vc: self, itemUrl: content[itemIndex]) { result in
                if result {
                    self.content.remove(at: itemIndex)
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

