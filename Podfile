# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target ‘RXSwiftTest’ do
def share
    pod 'ReactiveCocoa', '~> 2.5'
    pod 'pop', '~> 1.0'
end
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod ‘RxSwift’
  pod ‘RxCocoa’
  pod 'SnapKit','~> 3.2.0'
  pod 'Bugly'
  pod 'HandyJSON'
#  pod 'GTSDK', '1.6.2.0-noidfa'
#  pod 'TMCache'
  pod 'FCUUID'
  pod 'Then'
  pod 'Alamofire','~>4.4'
  pod 'MBProgressHUD'
  pod 'YYKit'
  pod 'Cache'
  pod 'CocoaSecurity'
  pod 'LEEAlert'
share
  # Pods for RXSwiftTest

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
