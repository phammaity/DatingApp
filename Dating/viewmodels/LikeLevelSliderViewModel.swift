//
//  LikeLevelSliderViewModel.swift
//  Dating
//
//  Created by MacMini on 7/8/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import Foundation

class LikeLevelSliderViewModel {
    
    /// keep level how much do you like
    private var level:Int = 0
    
    /// keep username
    private var name:String = ""
    
    init(level:Int, name:String) {
        self.level = level
        self.name = name
    }
    
    func setLevel(level:Int) {
        self.level = level
    }
    
    func getCurrentLevel() -> Int {
        return self.level
    }
    
    func getName() -> String {
        return self.name
    }
}
