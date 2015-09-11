//
//  DashboardVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/11/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ShortTrips
import Quick
import Nimble

class DashboardVCSpec: QuickSpec {
    override func spec() {
        var viewController: DashboardVC!
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main",
                bundle: NSBundle(forClass: self.dynamicType))
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            viewController = navigationController.topViewController as! DashboardVC
            
            UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
            let _ = navigationController.view
            let _ = viewController.view
        }
        
        it("has a terminal status button") {
            expect(viewController.statusButton).toNot(beNil())
        }
    }
}
