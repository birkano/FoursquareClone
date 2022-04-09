//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Birkan Pusa on 14.01.2022.
//

import Foundation
import UIKit

class PlaceModel {
        static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeDescription = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init () {}
    
}


