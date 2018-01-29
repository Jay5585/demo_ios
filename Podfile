# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BallerApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  
  pod 'Fabric'
  pod 'Crashlytics'
  
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire’, '~> 4.0'
  pod 'Font-Awesome-Swift', '~> 1.5'
  pod 'ReachabilitySwift', '~> 3'
  pod 'SDWebImage', '~> 4.0'
  pod 'SwiftEventBus', '~> 2.1'
  pod 'ActiveLabel'
  pod 'STPopup'
  pod 'Stripe'
  
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'DynamicBlurView'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
