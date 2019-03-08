//
//  PhotoWeatherTips.swift
//  Clima
//
//  Created by Efren Abraham Tavarez on 3/8/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class PhotoWeatherTips {
    var photoTip : String = ""
    
    func getPhotoTip(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300:
            return "Thunder Storms"
            
        case 301...500 :
            return "Light rain"
            
        case 501...600 :
            return "Showers"
            
        case 601...700 :
            return "Snow"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "Heavy Thunder Storm"
            
        case 800 :
            return "Sunny"
            
        case 801...804 :
            return "Cloudy"
            
        case 900...903, 905...1000  :
            return "Tstorm3"
            
        case 903 :
            return "Snow5"
            
        case 904 :
            return "Sunny"
            
        default:
            return "dunno"
        }
    }
}
