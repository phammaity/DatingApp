//
//  Profile.swift
//  Dating
//
//  Created by Ty Pham on 7/5/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import Foundation

struct DatingDataBase:Decodable {
    let profile:ProfileBackend
}

struct ProfileBackend:Decodable {
    let id:String?
    let username:String?
    let name: String?
    let birthdate: Int?
    let work: String?
    let education:String?
    let images:[String]?
    let bio:String?
    let moment:[MomentBackend]?
}

struct Profile {
    let id:String
    let username:String
    let name: String
    let birthdate: Date
    let work: String
    let education:String
    let images:[String]
    let bio:String
    var moment:[Moment]
    
    init(data:ProfileBackend) {
        self.id = data.id ?? ""
        self.username = data.username ?? "not updated"
        self.name = data.name ?? "not updated"
        self.birthdate = Date().intToDate(number: data.birthdate ?? 0) ?? Date()
        self.work = data.work ?? "not updated"
        self.education = data.education ?? "not updated"
        self.images = data.images ?? []
        self.bio = data.bio ?? "not updated"
        
        self.moment = []
        if let moments = data.moment {
            for item in moments {
                self.moment.append(Moment(data: item))
            }
        }
    }
}
