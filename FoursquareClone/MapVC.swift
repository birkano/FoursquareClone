//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Birkan Pusa on 14.01.2022.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()


    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //konumu en iyi doğrulukta al
        locationManager.requestWhenInUseAuthorization() //konum izni al
        locationManager.startUpdatingLocation() //lokasyonu update et
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(recognizer)
        
        

    }
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        //uzun basma işlemi yapıldıysa
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            //tıklanılan noktaları al
            let touches = gestureRecognizer.location(in: self.mapView)
            //alınan noktayı koordinata çevir
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation() //lokasyonu 1 kere update et ve dur
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked() {
        
        let object = PFObject(className: "Places")
        object["name"] = PlaceModel.sharedInstance.placeName
        object["type"] = PlaceModel.sharedInstance.placeType
        object["description"] = PlaceModel.sharedInstance.placeDescription
        object["latitude"] = PlaceModel.sharedInstance.placeLatitude
        object["longitude"] = PlaceModel.sharedInstance.placeLongitude
        
        if let imageData = PlaceModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground { success, error in
            if error != nil {
                let error = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                error.addAction(okButton)
                self.present(error, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
            
        
    }
    
    @objc func backButtonClicked() {
        //geri dön
        self.dismiss(animated: true, completion: nil)
        
    }


}
