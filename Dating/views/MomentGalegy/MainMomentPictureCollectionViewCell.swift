//
//  MainMomentPictureCollectionViewCell.swift
//  Dating
//
//  Created by Ty Pham on 7/6/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit

enum MomentStatus: String {
    case happy = "happy"
}

class MainMomentPictureCollectionViewCell: MomentPictureCollectionViewCell {

    @IBOutlet weak var bottomGradientView: GradientView!
    @IBOutlet weak var topGradientView: GradientView!
    @IBOutlet weak var locationICon: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var statuslabel: UILabel!
    @IBOutlet weak var locationContainer: UIView!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var momentDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateData(location:String, status:String, momentDescription:String) {
        self.locationLabel.text = location.capitalized
        self.momentDescriptionLabel.text = momentDescription
        
        guard let momentStatus = MomentStatus(rawValue: status) else {
            return
        }
        
        /// set status label and icon base on MomentStatus enum
        switch momentStatus {
        case .happy:
            self.statuslabel.text = "Happy"
            self.statusIcon.image = UIImage.init(named: "smiling")
            break
        }
    }
    
    func initUI(){
        topGradientView.applyGradient(type: .TopBottom)
        bottomGradientView.applyGradient(type: .BottomTop)
        
        locationContainer.layer.cornerRadius = 15
        locationContainer.layer.borderColor = UIColor.white.cgColor
        locationContainer.layer.masksToBounds = true
        locationContainer.layer.borderWidth = 1.0

        statusContainer.layer.cornerRadius = 15
        statusContainer.layer.borderColor = UIColor.white.cgColor
        statusContainer.layer.masksToBounds = true
        statusContainer.layer.borderWidth = 1.0
    }
}
