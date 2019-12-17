//
//  UIImageView+Extension.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .systemTeal
    activityIndicator.startAnimating()
    activityIndicator.center = center
    addSubview(activityIndicator)
    
    guard let url = URL(string: urlString) else {
        completion(.failure(.badURL))
        return
    }
        
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { [weak activityIndicator] (result) in
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
        }
        switch result {
        case .failure(let error):
            completion(.failure(.networkClientError(error)))
        case .success(let data):
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.imageDecodingError))
            }
        }
    }
  }
}
