//
//  MainTabBarController.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/4/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

enum MainTabs: Int {
  case Flights = 0
  case Lot = 1
  case Trip = 2
}

var MainTabBarController: UITabBarController {

  let mainTabBarController = TallTabBarController()
  
  let flightStatusNavVC = UINavigationController(rootViewController: TerminalSummaryVC())
  flightStatusNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Flights", comment: "").uppercaseString, image: Image.flightsIcon.image(), selectedImage: nil)
  
  let dashboardNavVC = UINavigationController(rootViewController: DashboardVC())
  dashboardNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Lot Status", comment: "").uppercaseString, image: Image.dashboardIcon.image(), selectedImage: nil)
  
  let shortTripNavVC = UINavigationController(rootViewController: ShortTripVC())
  shortTripNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Trip", comment: "").uppercaseString, image: Image.tripIcon.image(), selectedImage: nil)
  
  mainTabBarController.viewControllers = [
    flightStatusNavVC,
    dashboardNavVC,
    shortTripNavVC
  ]
  
  mainTabBarController.selectedIndex = MainTabs.Trip.rawValue
  mainTabBarController.tabBar.barTintColor = Color.TabBar.background
  mainTabBarController.tabBar.tintColor = UIColor.whiteColor()
  mainTabBarController.tabBar.translucent = false

  return mainTabBarController
}


