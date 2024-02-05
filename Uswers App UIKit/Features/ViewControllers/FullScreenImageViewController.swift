//
//  FullScreenImageViewController.swift
//  Random Users UIKit
//

import UIKit

@MainActor
final class FullScreenImageViewController: UIViewController {

    @ViewModel var viewModel: FullScreenImageViewModel

    private lazy var imageView: UIImageView = UIFactory.createImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadImage()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageView)
        imageView.frame = view.bounds

        addSwipeGesture(direction: .down)
        addSwipeGesture(direction: .up)
        addSwipeGesture(direction: .left)
        addSwipeGesture(direction: .right)
    }
    
    private func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissController))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    private func loadImage() {
        imageView.loadImage(viewModel.imageURL, 
                            placeholderImage: UIImage(named: Constants.Images.userLogo))
    }
    
    @objc private func dismissController() {
        dismiss(animated: true)
    }
}
