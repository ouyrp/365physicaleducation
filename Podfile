# Uncomment the next line to define a global platform for your project

platform :ios, '8.0'
use_frameworks!

target '365physicaleducation' do

   pod 'MBMotion'
   pod 'RxSwift'
   pod 'RxCocoa'
   pod 'Alamofire'
   pod 'SwiftyJSON'
   pod 'SnapKit'
   pod 'SVProgressHUD'
   pod 'SDWebImage'
   pod 'Kingfisher'
   pod 'Moya'
   pod 'MJRefresh'
   pod 'Masonry'
   pod 'Reusable'

  end

  target '365physicaleducationTests' do

  end

  target '365physicaleducationUITests' do

  end
  
  
  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
          end
      end
end
