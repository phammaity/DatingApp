//
//  DetailImageViewController.swift
//  Dating
//
//  Created by Ty Pham on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit
import SDWebImage

class DetailImageViewController: UIViewController {
    
    // MARK: UI elements
    @IBOutlet weak var image: UIImageView!
    private var imageUrl:String?
    
    // MARK: view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// fetch image from url
        if let imageUrl = self.imageUrl {
            image.sd_setImage(with: URL(string: imageUrl),
                              placeholderImage: UIImage(named: "placeholder"))
        }
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        /// close view
        self.dismiss(animated: true, completion: nil)
    }
    
    func setImageUrl(url:String) {
        self.imageUrl = url
    }
}
