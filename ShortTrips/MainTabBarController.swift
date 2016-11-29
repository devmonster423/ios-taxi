//
//  MainTabBarController.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/4/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

enum MainTabs: Int {
  case flights = 0
  case lot = 1
  case trip = 2
}

var MainTabBarController: UITabBarController {

  let mainTabBarController = TallTabBarController()
  
  let flightStatusNavVC = UINavigationController(rootViewController: TerminalSummaryVC())
  flightStatusNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Flights", comment: "").uppercased(), image: Image.flightsIcon.image(), selectedImage: nil)
  
  let dashboardNavVC = UINavigationController(rootViewController: DashboardVC())
  dashboardNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Lot Status", comment: "").uppercased(), image: Image.dashboardIcon.image(), selectedImage: nil)
  
  let shortTripNavVC = UINavigationController(rootViewController: ShortTripVC())
  shortTripNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Trip", comment: "").uppercased(), image: Image.tripIcon.image(), selectedImage: nil)
  
  mainTabBarController.viewControllers = [
    flightStatusNavVC,
    dashboardNavVC,
    shortTripNavVC
  ]
  
  let delegate = UIApplication.shared.delegate as! AppDelegate
  
  mainTabBarController.selectedIndex = delegate.appActiveFromPush
    ? MainTabs.lot.rawValue
    : MainTabs.trip.rawValue
  mainTabBarController.tabBar.barTintColor = Color.TabBar.background
  mainTabBarController.tabBar.tintColor = UIColor.white
  mainTabBarController.tabBar.isTranslucent = false

  return mainTabBarController
}
