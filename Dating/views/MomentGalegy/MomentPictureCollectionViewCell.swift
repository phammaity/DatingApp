//
//  MomentPictureCollectionViewCell.swift
//  Dating
//
//  Created by Ty Pham on 7/6/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit
import SDWebImage

class MomentPictureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setImage(urlString:String, size: CGSize) {
        /// set default image
        image.image = UIImage.init(named: "placeholder")
        
        /// fetch image by url
        SDWebImageManager.shared.loadImage(
            with: URL(string: urlString),
            options: [],
            progress: nil,
            completed: {[weak self](img, _, error, _, _, _) in
                /// validate variable
                guard let _self = self else { return }
                guard error == nil else { return }
                
                if var img = img {
                    /// resize image
                    img = resizeImage(image: img,
                                      targetSize: size) ?? UIImage()
                    _self.image.image = img
                }
            }
        )
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}
