//
//  InfoCollectionViewCell.swift
//  Dating
//
//  Created by Ty Pham on 7/6/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var ageInfoLabel: UILabel!
    @IBOutlet weak var jobInfoLabel: UILabel!
    @IBOutlet weak var schoolInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// setup auto calculate size of cell
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth
    }
    
    func initUI(name:String, ageInfo:String, jobInfo:String, schoolInfo:String, bio:String) {
        nameLabel.text = name
        ageInfoLabel.text = ageInfo
        jobInfoLabel.text = jobInfo
        schoolInfoLabel.text = schoolInfo
        bioLabel.text = bio
    }
}
