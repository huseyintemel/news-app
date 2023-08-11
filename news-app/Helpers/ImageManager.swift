//
//  ImageManager.swift
//  news-app
//
//  Created by huseyin on 17.07.2023.
//

import UIKit
import Kingfisher

class ImageManager {
    static let shared = ImageManager() //singleton pattern
    
    private init() {}
    
    let options: KingfisherOptionsInfo = [
           .transition(.fade(0.2)),
           .cacheOriginalImage
       ]
    
    func setImage(url:String,imageView:UIImageView){
        let url = URL(string: url)
        imageView.kf.setImage(with: url, options: options)
    }
}
