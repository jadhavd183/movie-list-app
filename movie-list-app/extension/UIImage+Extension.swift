//
//  UIImage+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit

extension UIImage {
    static func from(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
