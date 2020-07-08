//
//  ProfileViewModel.swift
//  Dating
//
//  Created by MacMini on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import Foundation

protocol ProfileDelegate:NSObject {
    func didFetchProfile()
    func fetchDataError(error:String)
}

class ProfileViewModel {
    
    private var profile:Profile?
    weak var delegate: ProfileDelegate?
    
    private var likeLevel = 0
    
    init(delegate:ProfileDelegate) {
        /// init delegate
        self.delegate = delegate
        
        /// fetch data from backend
        fetchData()
    }
    
    private func fetchData() {
        APIService.sharedService.getDatingDatabase {[weak self] (data, error) in
            guard let _self = self else {
                return
            }
            
            if let error = error {
                /// hanlde error call back
                _self.delegate?.fetchDataError(error: "fetch data failed:\(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                /// validate data
                return
            }
            /// update data
            _self.profile = Profile(data: data)
            
            /// notify UI
            _self.delegate?.didFetchProfile()
        }
    }
    
    //MARK: collection view
    func numberOfSection() -> Int {
        /// 2: one is horizontal images section and one is info section
        /// every moment is a section
        return 2 + numberOfMoments()
    }
    
    func isLargeImageAtIndex(index:Int, momentIndex:Int) -> Bool {
        if (index + 1) % 3 == 0 || (index + 2) % 3 == 0  {
            return false
        }
        return true
    }
    
    //MARK: header
    func getUsername() -> String {
        return profile?.username ?? ""
    }
    
    func profileAvatarImageUrl() -> String {
        //TODO: request backend avatar url
        return ""
    }
    
    func getLikeLevel() -> Int {
        return likeLevel
    }
    
    func setLikeLevel(level:Int) {
        likeLevel = level
    }
    
    //MARK: horizontal images
    func horizontalImageUrls() ->  [String] {
        return profile?.images ?? []
    }
    
    
    //MARK: profile info
    func getName() -> String {
        return profile?.name ?? ""
    }
    
    func getJob() -> String {
        return profile?.work ?? ""
    }
    
    func getSchoolName() -> String {
        return profile?.education ?? ""
    }
    
    func getBirthDateSting() -> String {
        guard let date = profile?.birthdate else {
            return "unknown"
        }
        
        /// format birth day
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM yyyy"
        return "\(dateFormatterPrint.string(from: date)), \(date.age()) years old"
    }
    
    func getBio() -> String {
        return profile?.bio ?? ""
    }
    
    //MARK: moment galeries
    func numberOfMoments() -> Int {
        return getMoments().count
    }
    
    func imageUrlAtIndex(index:Int, momentIndex:Int) -> String {
        return momentAtIndex(index: momentIndex).images[index]
    }
    
    func numberOfImagesAtMoment(index:Int) -> Int{
        return momentAtIndex(index: index).images.count
    }
    
    func momentLocationAtIndex(index:Int) -> String {
        let fullLocation = momentAtIndex(index: index).location
        
        /// get the first string of location
        /// example : "Da Lat, Lam Dong, Vietnam" -> "Da Lat"
        return fullLocation.split{$0 == ","}.map(String.init).first ?? fullLocation
    }
    
    func momentStatusAtIndex(index:Int) -> String {
        //TODO: dummy data
        return "happy"
    }
    
    func momentDescriptionAtIndex(index:Int) -> String {
        let fullLocation = momentAtIndex(index: index).location
        if fullLocation.isEmpty {
            return ""
        }
        return "When in \(fullLocation)"
    }
    
    private func momentAtIndex(index:Int) -> Moment {
        /// index - 2: "2" means one is horizontal images section and one is info section
        return getMoments()[index - 2]
    }
    
    private func getMoments() -> [Moment] {
        return profile?.moment ?? []
    }
}
