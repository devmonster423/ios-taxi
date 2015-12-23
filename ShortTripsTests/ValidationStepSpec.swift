//
//  ValidationStepSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

var MockValidationStepString = "{\"step_id\": 2, \"name\": \"validate_vehicle\", \"description\": \"Vehicle miss match found (123,null)\"}"

class ValidationStepSpec: QuickSpec {
  var validationStepWrapper1: ValidationStepWrapper!
  var validationStepWrapper2: ValidationStepWrapper!
  
  override func spec() {
    describe("the FoundGeofenceStatus") {
      beforeEach {
        self.validationStepWrapper1 = Mapper<ValidationStepWrapper>().map(MockValidationStepString)
        
        let validationStep = ValidationStep.Vehicle
        validationStep.name()
        validationStep.description()
        
        self.validationStepWrapper2 = ValidationStepWrapper(validationStep: validationStep)
      }
      
      it("is non-nil") {
        expect(self.validationStepWrapper1).toNot(beNil())
        expect(self.validationStepWrapper1.validationStep).toNot(beNil())
        expect(self.validationStepWrapper2).toNot(beNil())
        expect(self.validationStepWrapper2.validationStep).toNot(beNil())
      }
    }
  }
}
