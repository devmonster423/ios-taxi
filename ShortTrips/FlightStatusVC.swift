//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class FlightStatusVC: UIViewController {
  
  @IBOutlet var flightTable: UITableView!
  @IBOutlet var domesticButton: UIButton!
  @IBOutlet var internationalButton: UIButton!
  var terminal: Int?
  
  var testFlightDelegate: TestFlightDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testFlightDelegate = TestFlightDelegate(flightTableView: flightTable)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    SfoInfoRequester.requestFlights({ (flights, error) -> Void in
      if let flights = flights {
        println("flight 0: \(flights[0].flightStatus)")
      }
      else {
        println("error: \(error)")
      }
    }, terminal: 1)
  }
  
  // MARK: IBActions and helper
  
  @IBAction func showDomestic() {
    if testFlightDelegate.domesticOrInternational == DomesticOrInternational.International {
      testFlightDelegate.domesticOrInternational = DomesticOrInternational.Domestic
      testFlightDelegate.filterFlights()
      invertDomesticAndInternationalButtonColors()
    }
  }
  
  @IBAction func showInternational() {
    if testFlightDelegate.domesticOrInternational == DomesticOrInternational.Domestic {
      testFlightDelegate.domesticOrInternational = DomesticOrInternational.International
      testFlightDelegate.filterFlights()
      invertDomesticAndInternationalButtonColors()
    }
  }
  
  func invertDomesticAndInternationalButtonColors() {
    let newDomesticTextColor = internationalButton.titleColorForState(UIControlState.Normal)
    let newDomesticBackgroundColor = internationalButton.backgroundColor
    let newInternationalTextColor = domesticButton.titleColorForState(UIControlState.Normal)
    let newInternationalBackgroundColor = domesticButton.backgroundColor

    domesticButton.setTitleColor(newDomesticTextColor, forState: UIControlState.Normal)
    domesticButton.backgroundColor = newDomesticBackgroundColor
    internationalButton.setTitleColor(newInternationalTextColor, forState: UIControlState.Normal)
    internationalButton.backgroundColor = newInternationalBackgroundColor
  }
}