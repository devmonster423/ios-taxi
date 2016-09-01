//
//  SettingsVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class SettingsVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: SettingsVC!
    
    describe("the settings view controller") {
      
      beforeEach {
        
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
        
        viewController = SettingsVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
        (viewController.view as! SettingsView).tableView.reloadData()
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      it("can get the phone model name") {
        expect(UIDevice.currentDevice().modelName).toNot(beNil())
      }
    }
  }
}
