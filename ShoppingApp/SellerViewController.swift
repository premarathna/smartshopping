//
//  SellerViewController.swift
//  ShoppingApp
//
//  Created by Aruna Lakmal2 on 9/17/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class SellerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    @IBOutlet weak var otherTxt: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    let locationManager = CLLocationManager()
    var location: String?
    var itemImage: UIImage?
    var latitude: Double?
    var longitude: Double?
    var price: Double?
    var name: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardOnTap()
        checkLocationServices()
        
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        
        if  !self.nameTxt.text!.isEmpty && !self.priceTxt.text!.isEmpty && !self.otherTxt.text!.isEmpty && !self.imageView.image!.isProxy() && !self.locationTxt.text!.isEmpty
{
        var imageData: Data?
        
        print("------")
        
        if let itemImage = itemImage {
            imageData = itemImage.jpegData(compressionQuality: 0.5)
        }

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Items", in: context)

        let items = Items(entity: entity!, insertInto: context)
        items.name = nameTxt.text
        items.price = Double(priceTxt.text!)!
        items.details = otherTxt.text
        items.location = self.location
        items.image = imageData as NSData?
        items.latitude = latitude!
        items.longitude = longitude!

        try!  context.save()
        
        nameTxt.text = ""
        priceTxt.text = ""
        otherTxt.text = ""
        imageView.image = nil
        }
        
        else{
            let alert = UIAlertController(title: "Warning!", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)        }
    }
    

    
    @IBAction func btnTakeImage(_ sender: Any) {
        
        locationManager.startUpdatingLocation()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.itemImage = image
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SellerViewController:  CLLocationManagerDelegate  {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate = locations[0].coordinate
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        
        getLocation(location: locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getLocation(location: CLLocation) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            
            self.location = "\(streetName), \(city)"
            
            DispatchQueue.main.async {
                self.locationTxt.text = self.location
            }
            
            self.locationManager.stopUpdatingLocation()
        }
    }
}
