//
//  UIImageViewExtension.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import Foundation
import UIKit

private let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(urlString: String) {
        image = UIImage(named: "placeholderImage")
        if let strUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            if let cachedImage = cache.object(forKey: strUrl as NSString) {
                self.image = cachedImage
            } else {
                NetworkClient.sharedClient.getRequestForImage(url: imgUrl) { [weak self] data, error in
                    if let dataObject = data {
                        if let image = UIImage(data: dataObject) {
                            cache.setObject(image, forKey: strUrl as NSString)
                            DispatchQueue.main.async {
                                self?.image = image
                            }
                        }
                    }
                }
            }
        }
    }
}
