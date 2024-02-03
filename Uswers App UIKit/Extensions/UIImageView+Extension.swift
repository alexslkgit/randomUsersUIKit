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

        Task { @MainActor in
            if let smallImage = await downloadImage(from: smallImageUrl) {
                self.image = smallImage
            }
            
            if let largeImage = await downloadImage(from: imageUrl) {
                self.image = largeImage
            }
        }
    }
    
    private func downloadImage(from urlConvertible: URLConvertible?) async -> UIImage? {
        
        guard let urlConvertible = urlConvertible, let url = urlConvertible.asURL() else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                debugPrint("Error procesing image from Data")
                return nil
            }
        } catch {
            debugPrint("Image loading error: \(error)")
            return nil
        }
    }
}
