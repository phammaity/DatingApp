//
//  File.swift
//  Dating
//
//  Created by MacMini on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit

class ThumbTextSlider: UISlider {
    
    private var thumbTextLabel: UILabel = UILabel()
    private var thumbContainer: UIView = UIView()
    let customThumbFrame:CGRect = CGRect(x: 0, y: 0, width: 36, height: 36)
    
    /// space from thumb to custom view
    let customThumnYPosition:CGFloat = 40

    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        /// update frame when thumb moving
        thumbContainer.frame = CGRect(x: thumbFrame.origin.x,
                                      y: thumbFrame.origin.y - customThumnYPosition,
                                      width: thumbFrame.size.width,
                                      height: thumbFrame.size.height)
        
        /// update value of textLabel when thumb moving
        thumbTextLabel.text = String(format: "%d", arguments: [Int(value)])

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// set UI
        thumbTextLabel.frame = customThumbFrame
        thumbTextLabel.text = ""
        thumbTextLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        thumbTextLabel.textColor = UIColor.white
        thumbTextLabel.textAlignment = .center
        
        let thumbImage: UIImageView = UIImageView.init(image: UIImage.init(named: "like"))
        thumbImage.frame = customThumbFrame
        thumbImage.contentMode = .scaleToFill
        thumbImage.tintColor = UIColor.init(red: 1, green: 70/255, blue: 114/255, alpha: 1)
        
        thumbContainer.addSubview(thumbImage)
        thumbContainer.addSubview(thumbTextLabel)
        addSubview(thumbContainer)
        thumbContainer.layer.zPosition = layer.zPosition + 1
    }
}
