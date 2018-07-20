//
//  AppointmentViewController.swift
//  TBD
//
//  Created by George Muntean on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
import MapKit

class AppointmentViewController: UIViewController {

    @IBOutlet weak var appointmentName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var appointmentNameString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appointmentName.text = appointmentNameString
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 52.4496249, longitude:-1.9427613)
        annotation.coordinate = centerCoordinate
        annotation.title = "Queen Elizabeth Hospital, Birmingham"
        mapView.addAnnotation(annotation)
        mapView.showAnnotations(mapView.annotations, animated: true)
        // Do any additional setup after loading the view.
    }


}
