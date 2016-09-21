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
  fileprivate init() { }
  
  fileprivate let audioEnabledKey = "audioEnabled"
  
  func speak(_ input: String) {
    var input = input
    
    input = input.lowercased()
    
    input = input.replacingOccurrences(of: ". ", with: "... ")
    input = input.replacingOccurrences(of: "\n", with: "... ")
    input = input.replacingOccurrences(of: "geofence", with: "G oh fence")
    input = input.replacingOccurrences(of: "unavailable", with: "un available")
    input = input.replacingOccurrences(of: "reestablished", with: "ree established")
    
    if getAudioEnabled() {
      AVSpeechSynthesizer().speak(AVSpeechUtterance(string: input))
    }
  }
  
  func enableBackgroundAudio() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
    }
    catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
  
  func setAudioEnabled(_ on: Bool) {
    UserDefaults.standard.set(on, forKey: audioEnabledKey)
  }
  
  func getAudioEnabled() -> Bool {
    if let enabled = UserDefaults.standard.object(forKey: audioEnabledKey) as? Bool {
      return enabled
    } else {
      return true // default
    }
  }
}
