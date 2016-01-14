//
//  Speaker
//  ShortTrips
//
//  Created by Matt Luedke on 1/12/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import AVFoundation

struct Speaker {
  static func speak(var input: String) {
    input = input.lowercaseString
    
    input = input.stringByReplacingOccurrencesOfString("\n", withString: "... ")
    input = input.stringByReplacingOccurrencesOfString("geofence", withString: "G oh fence")
    
    AVSpeechSynthesizer().speakUtterance(AVSpeechUtterance(string: input))
  }
  
  static func enableBackgroundAudio() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptions.MixWithOthers)
    }
    catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
}
