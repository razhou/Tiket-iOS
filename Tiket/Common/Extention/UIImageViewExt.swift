//
//  UIImageViewExt.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 23/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    /// Set image download with animation
    /// - Parameter url: Url type of URL
    func downloadWithTransition(image url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_image_default"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }

}
