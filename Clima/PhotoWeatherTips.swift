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
            return "Light rain: Rain: When shooting in the rain I always wear oversize protective clothing and have my camera inside my jacket, nice and dry and easily accessible and ready to shoot when the right opportunity arises. Don’t change lenses. Instead, use a high-quality protective UV filter and a lens shade in front of the lens, and carry a clean soft cloth to dry the lens in case it does get a few drops. It never hurts to keep a large plastic bag in your pocket, just in case you get caught in a downpour. Finding a covered spot along the street, like an archway or awning, provides good protection so you can freely shoot."
            
        case 501...600 :
            return "Showers"
            
        case 601...700 :
            return "Snow: If you’re taking pictures as it’s snowing, be sure to cover your camera as it is essentially the same as shooting in rain. If you are out and about after it has snowed, keep in mind that the road conditions and walkways can be treacherous."
            
        case 701...771 :
            return "Fog: I love the way fog adds an element of mystique and interest without doing much. In technical terms, on a foggy day, the water particles in the air redirect the light rays, spreading them out more evenly. This almost acts like a giant softbox along the area in the fog giving you beautiful diffused light. Experiment in the fog to find the camera settings that best suit your needs but I have found that foggy conditions require longer exposures than normal since you are essentially dealing with overall less light. You can use a tripod to help reduce any camera shake. Keep in mind that like snow, fog is reflective, and it can fool your camera’s meter into thinking that there’s more light in the scene there actually is. Use exposure compensation just as you would when shooting a snowy landscape and even overexpose by a few stops if needed."
            
        case 772...799 :
            return "Heavy Thunder Storm"
            
        case 800 :
            return "Sunny: Take advantage of the sun light.Right sun can create a scenario where you have beautiful light and the ability to experiment with shadows. A great tip for photographing in the bright midday sun is taking pictures in open shade. This is when you position your subject in a shady part of the frame that’s closer to the light. You can also use a reflector if needed to bounce light from the sun onto the subject."
            
        case 801...804 :
            return "Cloudy: Overcast days are known for their diffused light. For some photographers, these are ideal conditions for shooting portraits as your subject will be evenly lit and there are no undesirable shadows or harsh lighting"
            
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
