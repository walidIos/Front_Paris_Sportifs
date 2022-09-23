//
//  UIImageView+extension.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 22/9/2022.
//

import Foundation
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    /*
     This function will load image from an external URL and save on cache to be reused
     */
    func load(url: URL) {
        if let img = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = img
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url as AnyObject)
                        self.image = image
                    }
                }
            }
        }
    }
}
extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
