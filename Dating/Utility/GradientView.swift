//
//  GradientView.swift
//  Dating
//
//  Created by MacMini on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit

/// support gradient dimension
enum GradientType {
    case TopBottom
    case BottomTop
}

class GradientView:UIView {
    
    var gradient:CAGradientLayer?
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        /// update frame of gradient  when view update
        gradient?.frame = self.bounds;
    }
    
    func applyGradient(type:GradientType) {
        
        /// avoid duplicate gradient added
        if gradient != nil {
            removeGradient()
        }
        
        gradient = CAGradientLayer.init(layer: layer)
        gradient?.frame = self.bounds
        gradient?.startPoint = CGPoint.zero
        gradient?.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        switch type {
        case .TopBottom:
            /// set color from dark to light
            gradient?.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor];
        case .BottomTop:
            /// set color from light to dark
            gradient?.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor];
        }
        
        if let gra = gradient {
            layer.insertSublayer(gra, at:0)
        }
    }
    
    func removeGradient() {
        gradient?.removeFromSuperlayer()
    }
}

