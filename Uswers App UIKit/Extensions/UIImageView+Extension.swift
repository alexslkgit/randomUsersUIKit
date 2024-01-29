//
//  UIImageView+Extension.swift
//  Random Users UIKit
//

import UIKit

extension UIImageView {
    
    func loadImage(_ imageUrl: URLConvertible?,
                   placeholderImage: UIImage? = nil,
                   smallImageUrl: URLConvertible? = nil) {
        
        self.image = placeholderImage
        
        let loadImageFromUrl: (URLConvertible?, @escaping (UIImage?) -> Void) -> Void = { [weak self] imageUrlConvertible, completion in
            guard let self = self, let urlConvertible = imageUrlConvertible, let url = urlConvertible.asURL() else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data, error == nil, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
        
        loadImageFromUrl(smallImageUrl) { [weak self] smallImage in
            if let smallImage = smallImage {
                self?.image = smallImage
            }
            
            loadImageFromUrl(imageUrl) { largeImage in
                if let largeImage = largeImage {
                    self?.image = largeImage
                }
            }
        }
    }
}
