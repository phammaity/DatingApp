//
//  LikeLevelSliderViewController.swift
//  Dating
//
//  Created by MacMini on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit
protocol LikeLevelSliderDelegate:NSObject {
    func didChangedLikeLevel(level:Int)
}

class LikeLevelSliderViewController: UIViewController {
    
    private var viewModel: LikeLevelSliderViewModel!
    weak var delegate: LikeLevelSliderDelegate?

    // MARK: UI elements
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var sliderbar: ThumbTextSlider!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// add action for black screen below slider view
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(didTapBlackScreen(_:)))
        singleTap.numberOfTapsRequired = 1
        self.blackView.addGestureRecognizer(singleTap)
        
        /// set slider value
        self.sliderbar.value = Float(viewModel.getCurrentLevel())
        self.questionLabel.text = "How much do you like \(viewModel.getName())?"
    }
    
    func initSliderView(likeLevel:Int, name:String, delegate:LikeLevelSliderDelegate) {
        self.delegate = delegate
        viewModel = LikeLevelSliderViewModel(level: likeLevel, name: name)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        /// update level after slider changed
        viewModel.setLevel(level: Int(sender.value))
    }
    
    @objc func didTapBlackScreen(_:UITapGestureRecognizer){
        /// turn off this screen
        self.dismiss(animated: true) {
            /// notify close view and return level changed
            self.delegate?.didChangedLikeLevel(level: self.viewModel.getCurrentLevel())
        }
    }
}
