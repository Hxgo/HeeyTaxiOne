//
//  LibreViewController.swift
//  HeeyTaxiPrototipe
//
//  Created by Hxgo De la rosa on 5/15/17.
//  Copyright © 2017 Hxgo De la rosa. All rights reserved.
//

import UIKit

//  This Class is linked with second View Controller (Libre View Controller),
//  here appears three options of taxi.
//  Taxi Libre - Taxi Sitio - Radio Taxi
//
class LibreViewController: UIViewController {

    @IBOutlet weak var labelTaxi: UILabel!
    
    //  If the "Regresar" button is pressed, the user back to the home view.
    //
    @IBAction func backHome(_ sender: Any) {
        
        let vcB = self.storyboard?.instantiateViewController(withIdentifier: "homeView")
        present(vcB!, animated: true, completion: nil)
    }
    
    //  Button - Taxi Libre
    //
    @IBAction func pressLibre(_ sender: Any) {
        
        performSegue(withIdentifier: "freeSegue", sender: self)
    }
    
    //  Button - Taxi Sitio
    //
    @IBAction func pressSitio(_ sender: Any) {
        
        performSegue(withIdentifier: "siteSegue", sender: self)
    }
    
    //  Button - Radio Taxi
    //
    @IBAction func pressRadio(_ sender: Any) {
        
        performSegue(withIdentifier: "radioSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let pressController = segue.destination as! OcupadoViewController
        
        if segue.identifier == "freeSegue" {
            
            pressController.passData = "$\(pressController.tarifaLibre)"
            pressController.flagFree = true
            
        } else if segue.identifier == "siteSegue" {
            
            pressController.passData = "$\(pressController.tarifaSitio)0"
            pressController.flagSite = true
            
        } else {
            
            pressController.passData = "$\(pressController.tarifaRadio)0"
            pressController.flagRadio = true
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTaxi.text = "Elije el tipo de taxi"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
