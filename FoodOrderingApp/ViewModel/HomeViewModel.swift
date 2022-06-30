//
//  HomeViewModel.swift
//  FoodOrderingApp
//
//  Created by Sadman Adib on 30/6/22.
//

import SwiftUI
import CoreLocation

// Fetching User Location...
class HomeViewModel:  NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var search = ""
    @Published var locationManager = CLLocationManager()
    
    //location details
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //checking location access
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            self.noLocation = false
            print("unknown")
            //direct call
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //reading user location and updating details
        
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else {return}
            
            var address = ""
            
            // getting area and locality name
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
        
    }
    
    
}
