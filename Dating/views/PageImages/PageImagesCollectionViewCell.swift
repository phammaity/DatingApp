//
//  PageImagesCollectionViewCell.swift
//  Dating
//
//  Created by Ty Pham on 7/6/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit
import SDWebImage

class PageImagesCollectionViewCell: UICollectionViewCell, SDWebImageManagerDelegate {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initUI(imageUrls:[String], width:CGFloat, height:CGFloat) {
        
        /// create UIImageViews and added to content of scrollview
        for (index,imageUrl) in imageUrls.enumerated() {
            let newImageView = imageViewWithUrl(urlString: imageUrl, size: CGSize(width: width, height: height))
            newImageView.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: height)
            imageContainerView.addSubview(newImageView)
        }
        
        /// setup pageControl
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = imageUrls.count
        pageControl.currentPage = 0
        
        /// setup scrollview
        scrollView.isPagingEnabled = true
        widthConstraint.constant = width * CGFloat(imageUrls.count)
    }

    /// create UIImageView from url
    private func imageViewWithUrl(urlString:String, size:CGSize) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        
        SDWebImageManager.shared.loadImage(
            with: URL(string: urlString),
            options: [],
            progress: nil,
            completed: {(image, data, error, cacheType, finished, url) in
                //guard let self = self else { return }
                guard error == nil else { return }
                if var image = image {
                    image = resizeImage(image: image, targetSize: size) ?? UIImage()
                    imageView.image = image
                }
            }
        )
        return imageView
    }
}

extension PageImagesCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// update pageIndex after scrolling
        let pageIndex = round(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
