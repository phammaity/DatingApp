//
//  Moment.swift
//  Dating
//
//  Created by Ty Pham on 7/5/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import Foundation

struct MomentBackend:Decodable {
    let id:String?
    let location:String?
    let date:Int?
    let images:[String]?
}

struct Moment {
    let id:String
    var location:String
    let date:Date
    let images:[String]
    
    init(data:MomentBackend) {
        self.id = data.id ?? ""
        self.date = Date().intToDate(number: data.date ?? 0) ?? Date()
        self.location = data.location ?? ""
        self.images = data.images ?? []
    }
}



