//
//  CLService.swift
//  Remind
//
//  Created by Станислав Коцарь on 21.04.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject {
    private override init () {}
    
    static let shared = CLService()
    
    let locationManager = CLLocationManager()
    var shouldSetRegion = true
    
    func authorize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation () {
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("DID ENTER REGION VIA CL")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
    }
    
}
