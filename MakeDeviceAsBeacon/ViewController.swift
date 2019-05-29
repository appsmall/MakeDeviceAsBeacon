//
//  ViewController.swift
//  MakeDeviceAsBeacon
//
//  Created by apple on 28/01/19.
//  Copyright © 2019 appsmall. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController {
    
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: [String:Any] = ["name" : "rahul chopra"]
    var peripheralManager: CBPeripheralManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocalBeacon()
    }
    
    func initLocalBeacon() {
        if localBeacon != nil {
            stopLocalBeacon()
        }
        
        let localBeaconUUID = "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"
        let localBeaconMajor: CLBeaconMajorValue = 123
        let localBeaconMinor: CLBeaconMinorValue = 456
        
        let uuid = UUID(uuidString: localBeaconUUID)!
        localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "Your private identifer here")
        
        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil) as! [String : Any]
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func stopLocalBeacon() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        //beaconPeripheralData = nil
        localBeacon = nil
    }
    
}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData)
        } else {
            peripheralManager.stopAdvertising()
        }
    }
    
}
