//
//  UserLocationViewModel.swift
//  Weather
//
//  Created by Sudhir Pawar on 20/09/23.
//

import Foundation
import CoreLocation

class UserLocationViewModel: NSObject {
    
    var userlocation = String()
     var locationManager = CLLocationManager()
    
    var delegate: UserLocationDelegate?
   

    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
   
    func requestOnTimeLocation() {
        
        locationManager.requestLocation()
        
    }

}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}


extension UserLocationViewModel: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")

//      location = CLLocation(latitude:  12.9719, longitude: 77.5937)
        location.fetchCityAndCountry { [self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            
            self.userlocation = city + ", " + country
//            self.requestCustomLocation(for: userlocation)
            delegate?.didReceivedLocation(userLocationString: userlocation)
            
        }
      
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
            case .notDetermined:
                print("When user did not yet determined")
            case .restricted:
                print("Restricted by parental control")
            case .denied:
                print("When user select option Dont't Allow")
            case .authorizedWhenInUse:
                print("When user select option Allow While Using App or Allow Once")
                locationManager.requestAlwaysAuthorization()
            default:
                print("default")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        
        if let clErr = error as? CLError {
            switch clErr.code {
                case .locationUnknown, .denied, .network:
                    print("Location request failed with error: \(clErr.localizedDescription)")
                case .headingFailure:
                    print("Heading request failed with error: \(clErr.localizedDescription)")
                case .rangingUnavailable, .rangingFailure:
                    print("Ranging request failed with error: \(clErr.localizedDescription)")
                case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                    print("Region monitoring request failed with error: \(clErr.localizedDescription)")
                default:
                    print("Unknown location manager error: \(clErr.localizedDescription)")
            }
        } else {
            print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
        }
        
    }
}
