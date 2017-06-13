//
//  OcupadoViewController.swift
//  HeeyTaxiPrototipe
//
//  Created by Hxgo De la rosa on 5/19/17.
//  Copyright © 2017 Hxgo De la rosa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//  This Class contains the user location and show the time of trip,
//  distance traveled, and price of trip.
//
class OcupadoViewController: UIViewController, CLLocationManagerDelegate {

    // Hxgo:
    // Class attributes
    var passData = String()
    var flagFree = false
    var flagSite = false
    var flagRadio = false
    var flag = true
    //var costo = String()
    
    var tarifaLibre: Double = 8.74
    let incLibre: Double = 1.07
    
    var tarifaSitio: Double = 13.10
    let incSitio: Double = 1.30
    
    var tarifaRadio: Double = 27.30
    let incRadio: Double = 1.84
    
    var timer = Timer()
    
    let locManTrip = CLLocationManager()
    
    // set of time`s labels
    @IBOutlet weak var sSecondlbl: UILabel!
    @IBOutlet weak var fSecondlbl: UILabel!
    @IBOutlet weak var sMinutelbl: UILabel!
    @IBOutlet weak var fMinutelbl: UILabel!
    var seconds = Timer()
    var sSec: Int = 0
    var fSec: Int = 0
    var sMin: Int = 0
    var fMin: Int = 0
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var taxiMap: MKMapView!
    
    //  If the "Cancel" button is pressed, the trip will be canceled
    //  and back to the Libre View.
    //
    @IBAction func cancelAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //  Manage user location
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
                                                                        [CLLocation]) {
        
        let moveLocation = locations[0]
        let moveSpan: MKCoordinateSpan = MKCoordinateSpanMake(0.001,0.001)
        let thisLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:
                                                    moveLocation.coordinate.latitude,
                                                    longitude: moveLocation.coordinate.longitude)
        let moveRegion: MKCoordinateRegion = MKCoordinateRegion(center: thisLocation, span: moveSpan)
        taxiMap.setRegion(moveRegion, animated: true)
        
        print(moveLocation.speed)
        taxiMap.showsUserLocation = true
        taxiMap.isZoomEnabled = true
        
        
    }
    
    //  Function to calculate price based on "Taxi Libre" oficial rate
    //
    func startFree() {
        
        tarifaLibre += incLibre
        lblRate.text = "$" + String(format: "%.2f", tarifaLibre)
    }
    
    //  Function to calculate price based on "Taxi Sitio" oficial rate
    //
    func startSite() {
        
        tarifaSitio += incSitio
        lblRate.text = "$" + String(format: "%.2f", tarifaSitio)
    }
    
    //  Function to calculate price based on "Radio Taxi" oficial rate
    //
    func startRadio() {
        
        tarifaRadio += incRadio
        lblRate.text = "$" + String(format: "%.2f", tarifaRadio)
    }
    
    //  Make a clock to calculate rate based on time
    //
    func runClock() {
        
        sSec += 1
        sSecondlbl.text = String(sSec)
        
        if sSec == 10 {
            sSec = 0
            sSecondlbl.text = String(sSec)
            fSec += 1
            fSecondlbl.text = String(fSec)
            
            if fSec == 6 {
                fSec = 0
                fSecondlbl.text = String(fSec)
                sSec = 0
                sSecondlbl.text = String(sSec)
                sMin += 1
                sMinutelbl.text = String(sMin)
                
                if sMin == 10 {
                    sMin = 0
                    sMinutelbl.text = String(sMin)
                    fMin += 1
                    fMinutelbl.text = String(fMin)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seconds.invalidate()
        
        //  Set map to show location
        locManTrip.delegate = self
        locManTrip.desiredAccuracy = kCLLocationAccuracyBest
        locManTrip.requestWhenInUseAuthorization()
        locManTrip.startUpdatingLocation()
        
        switch flag {
        case flagFree == true:
            timer.invalidate()
            lblRate.text = passData
            timer = Timer.scheduledTimer(timeInterval: 45, target: self,
                                         selector: #selector(startFree), userInfo: nil, repeats: true)
        case flagSite == true:
            timer.invalidate()
            lblRate.text = passData
            timer = Timer.scheduledTimer(timeInterval: 45, target: self,
                                         selector: #selector(startSite), userInfo: nil, repeats: true)
        case flagRadio == true:
            timer.invalidate()
            lblRate.text = passData
            timer = Timer.scheduledTimer(timeInterval: 45, target: self,
                                         selector: #selector(startRadio), userInfo: nil, repeats: true)
        default:
            print("Heey Taxi!! v1.0")
        }
        
        seconds = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runClock),
                                       userInfo: nil, repeats: true)
    }
    
    //  If "Detener" button is pressed, the clock and the function will stop
    //
    @IBAction func stopTaxi(_ sender: Any) {
        
        timer.invalidate()
        seconds.invalidate()
        
        makeAlert(title: "A PAGAR:", message: lblRate.text!)
    }
    
    //  Create an alert when the "Detener" button is pressed
    //
    func makeAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,
                                      handler: {(action) in alert.dismiss(animated: true,
                                                                          completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
