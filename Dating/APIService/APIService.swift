//
//  APIService.swift
//  Dating
//
//  Created by Ty Pham on 7/5/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import Alamofire

class APIService: NSObject {
    static let sharedService = APIService()
    
    func getDatingDatabase(callback: @escaping (ProfileBackend?, Error?) -> ()) {
        /// request url
        let fetchUrl = "https://my-json-server.typicode.com/thailemeetai/mobile-assignment/db"
        
        AF.request(fetchUrl,method: .get).responseDecodable(of: DatingDataBase.self) { response in
            
            switch response.result {
                case .success:
                    NSLog("Fetch data Successful")
                case let .failure(error):
                    NSLog(error.errorDescription ?? "error")
            }
            
            /// check if error happened
            if let error = response.error {
                callback(nil,error)
                return
            }
            
            /// check valid data
            guard let data = response.value else {
                let error = NSError(domain:"data nil", code:0, userInfo:nil)
                callback(nil,error)
                return
            }
            
            /// return data
            callback(data.profile,nil)
        }
    }
    
}
