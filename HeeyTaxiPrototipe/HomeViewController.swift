//
//  HomeViewController.swift
//  HeeyTaxiPrototipe
//
//  Created by Hxgo De la rosa on 5/15/17.
//  Copyright © 2017 Hxgo De la rosa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//  This Class represents the home view in the user interface
//  Contains the MapView, "Nuevo" button, "Tarifas Vigentes" button,
//  and the "Historial de Viajes" button.
//
class HomeViewController: UIViewController, CLLocationManagerDelegate {

    //  Hxgo:
    //  Class Attributes
    //
    let locationMan = CLLocationManager()
    let url = URL(string:
        "http://www.semovi.cdmx.gob.mx/tramites-y-servicios/transporte-de-pasajeros/nuevas-tarifas-de-transporte-publico-vigentes")
    
    //  This function is called if the "Nuevo" button is pressed
    //  then shows the next view
    //
    @IBAction func newTrip(_ sender: Any) {
        
        let vcN = self.storyboard?.instantiateViewController(withIdentifier: "libreView")
        present(vcN!, animated: true, completion: nil)
    }
    
    //  Map view Outlet
    //  Show the user location
    //
    @IBOutlet weak var mapHome: MKMapView!
    
    //  If the button "Tarifas vigentes" is pressed, open the link with
    //  official rates ofered by SEMOVI
    //
    @IBAction func openWeb(_ sender: Any) {
        
        UIApplication.shared.open(url!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
                                                                            [CLLocation]) {
        
        let homeLocation = locations[0]
        let homeSpan: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let theLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:
                                                    homeLocation.coordinate.latitude,
                                                    longitude: homeLocation.coordinate.longitude)
        let homeRegion: MKCoordinateRegion = MKCoordinateRegion(center: theLocation, span: homeSpan)
        mapHome.setRegion(homeRegion, animated: true)
        self.mapHome.showsUserLocation = true
        self.mapHome.isZoomEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyBest
        locationMan.requestWhenInUseAuthorization()
        locationMan.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
