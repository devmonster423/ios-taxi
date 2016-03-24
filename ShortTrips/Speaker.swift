//
//  Speaker
//  ShortTrips
//
//  Created by Matt Luedke on 1/12/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import AVFoundation

class Speaker {
  
  static let sharedInstance = Speaker()
  private init() { }
  
  private let audioEnabledKey = "audioEnabled"
  
  func speak(var input: String) {
    input = input.lowercaseString
    
    input = input.stringByReplacingOccurrencesOfString(". ", withString: "... ")
    input = input.stringByReplacingOccurrencesOfString("\n", withString: "... ")
    input = input.stringByReplacingOccurrencesOfString("geofence", withString: "G oh fence")
    input = input.stringByReplacingOccurrencesOfString("unavailable", withString: "un available")
    
    if getAudioEnabled() {
      AVSpeechSynthesizer().speakUtterance(AVSpeechUtterance(string: input))
    }
  }
  
  func enableBackgroundAudio() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptions.MixWithOthers)
    }
    catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
  
  func setAudioEnabled(on: Bool) {
    NSUserDefaults.standardUserDefaults().setBool(on, forKey: audioEnabledKey)
  }
  
  func getAudioEnabled() -> Bool {
    if let enabled = NSUserDefaults.standardUserDefaults().objectForKey(audioEnabledKey) as? Bool {
      return enabled
    } else {
      return true // default
    }
  }
}
