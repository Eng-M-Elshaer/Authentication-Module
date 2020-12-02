//
//  MapCenterVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 6/9/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapCenterDelegate Protocol.
protocol MapCenterDelegate {
    func setDelailLocationInAddress(delailsAddress: String,tag:Int)
}

class MapCenterVC: UIViewController {

    // MARK: - Outlets.
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    // MARK: - Variables.
    var delegate: MapCenterDelegate?
    lazy var geocoder = CLGeocoder()
    var tag = 0
    
    // MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Actions.
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - MKMapViewDelegate Extension.
extension MapCenterVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
           let center = mapView.centerCoordinate
           print(center)
           getNameOfLocation(lat: center.latitude, long: center.longitude)
       }
}

// MARK: - MapCenterVC Extension.
extension MapCenterVC {
    
    private func getNameOfLocation(lat:CLLocationDegrees,long:CLLocationDegrees) {
        
        let location = CLLocation(latitude: lat, longitude: long)
        
        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            userLocationLabel.text = "Unable to Find Address for Location"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                userLocationLabel.text = placemark.compactAddress ?? ""
                delegate?.setDelailLocationInAddress(delailsAddress: placemark.compactAddress ?? "N/A", tag: tag)
            } else {
                userLocationLabel.text = "No Matching Addresses Found"
                delegate?.setDelailLocationInAddress(delailsAddress: "No Matching Addresses Found", tag: tag )
            }
        }
    }
}
