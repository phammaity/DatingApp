//
//  ImageExtension.swift
//  Dating
//
//  Created by Ty Pham on 7/7/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    /// get new size base on ratio
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    /// rect to draw new image
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    /// resize image with new size
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
}


extension Date {
    func intToDate(number:Int) -> Date? {
        /// convert Int to Double
        let timeInterval = Double(number)

        /// create NSDate from Double (NSTimeInterval)
        return Date(timeIntervalSince1970: timeInterval)
    }

    /// get component from Date
    /// example: "12/29/2020" => 2020
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    /// get age of person from birthday
    /// example: birthday is "12/29/1994" => age = 26
    func age() -> Int {
        return Date().get(.year) - get(.year) 
    }
}
