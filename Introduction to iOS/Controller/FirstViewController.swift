//
//  FirstViewController.swift
//  Introduction to iOS
//
//  Created by Alina FESYK on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import UIKit
import MapKit

class Uf: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String? {
        return locationName
    }
}

class FirstViewController: UIViewController {

	var chosenSchool = SchoolData()
	
    @IBAction func segCtrlAction(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }

    @IBOutlet weak var mapView: MKMapView!

    let uf = Uf(title: "UNIT Factory",
                locationName: "Educational institution",
                coordinate: CLLocationCoordinate2D(latitude: 50.469713, longitude: 30.462223))
	
	let lat: CLLocationDegrees = 50.468879
	let lon: CLLocationDegrees = 30.462173
	
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenSchool.name.count != 0 {
            let lat: CLLocationDegrees = chosenSchool.lat
            let lon: CLLocationDegrees = chosenSchool.lon
            print("===================", chosenSchool.name)
        }
		let initialLocation = CLLocation(latitude: lat, longitude: lon)
        mapView.delegate = self
		mapView.addAnnotation(uf)
		centerMapOnLocation(location: initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension FirstViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Uf else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
