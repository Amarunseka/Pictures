//
//  PhotoViewController.swift
//  Pictures
//
//  Created by Миша on 10.03.2022.
//

import UIKit

class PhotoViewController: UINavigationController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0.7
        return view
    }()
    
    private let crossCloseWindowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()

    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true

        setupView()
        setupConstraints()
    }

    
    private func setupView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        crossCloseWindowButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backgroundView)
        containerView.addSubview(imageView)
        containerView.addSubview(crossCloseWindowButton)
    }

    
    private func setupConstraints(){
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            backgroundView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            crossCloseWindowButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            crossCloseWindowButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func dismissVC(){
        self.dismiss(animated: true)
    }
}
