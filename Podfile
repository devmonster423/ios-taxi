platform :ios, '8.0'
use_frameworks!

def shared_pods
  pod 'Alamofire', '2.0'
  pod 'AlamofireObjectMapper', '0.9'
end

target 'ShortTrips' do
  shared_pods
end

target 'ShortTripsTests' do
  shared_pods
  
  pod 'Quick', '0.6.0'
  pod 'Nimble', '2.0.0-rc.3'
  
  pod 'PivotalCoreKit', '0.3.0'
  pod 'PivotalCoreKit/UIKit/SpecHelper/Extensions'
end
