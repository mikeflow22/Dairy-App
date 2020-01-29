//
//  DetailEntryViewController.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit
import CoreLocation

class DetailEntryViewController: UIViewController {

    //MARK: - Class Instance Properties
    var locationManager: CLLocationManager?
    var longitude: Double?
    var latitude: Double?
    var entry: Entry?{
        didSet {
            updateViews()
        }
    }
    
    //MARK: IBoutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveProperties: UIBarButtonItem!
    @IBOutlet weak var deleteProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setUpLocationManager()
    }
    
    //MARK: - Instance Methods
    private func updateViews(){
        guard let passedInEntry = entry, isViewLoaded else {
            self.title = "Enter New Entry"
            deleteProperties.isHidden = true
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        
        self.title = passedInEntry.name
        nameTextField.text = passedInEntry.name
        bodyTextView.text = passedInEntry.body
        deleteProperties.isHidden = false
    }
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //check authorization
        checkLocationAuthorization()
        
        guard let name = nameTextField.text, !name.isEmpty, let long = longitude, let lat = latitude else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        if let passedInEntry = entry {
            //we already have an entry so we updating
            EntryController.shared.update(entry: passedInEntry, withNewName: name, withNewBody: bodyTextView.text, withNewLongitude: long, withNewLatitude: lat)
        } else {
            //we  dont have an entry so create
            EntryController.shared.createEntryWith(name: name, body: bodyTextView.text, longitude: long, latitude: lat)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if let passedInEntry = entry {
            EntryController.shared.delete(entry: passedInEntry)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension DetailEntryViewController: CLLocationManagerDelegate {
    //MARK: - LOCATION PRIVATE METHODS
    private func setUpLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization(){
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //user has authorized us permission to check location
            locationManager?.requestLocation() //see if this triggers a delegate callback it does, didupdateLocation
        } else {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: -CLLOCATION DELEGATE METHODS
    //when the user selects a choice in the pop up or goes into settings and manually changes the authorization status, this delegate method is triggered
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
              case .authorizedAlways, .authorizedWhenInUse:
                  locationManager?.requestLocation() //this triggers a delegate callback
              case .restricted:
                  print("restricted")
                   locationManager?.stopUpdatingLocation()
              case .notDetermined:
                  print("not determined")
                   locationManager?.stopUpdatingLocation()
              case .denied:
                  locationManager?.stopUpdatingLocation()
              @unknown default:
                  fatalError()
              }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location =  locations.last else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        
    }
}
