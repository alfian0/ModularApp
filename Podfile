use_frameworks!
platform :ios, '10.0'

workspace 'Monolith'

def common
  pod 'Swinject'
end

target 'Core' do
  project 'Core/Core.xcodeproj'
  common
end

target 'AuthManager' do
  project 'AuthManager/AuthManager.xcodeproj'
  common
end

target 'MainApplication' do
  project 'MainApplication/MainApplication.xcodeproj'
  common
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
end

target 'Repository' do
  project 'Repository/Repository.xcodeproj'
  common
end

target 'Networking' do
  project 'Networking/Networking.xcodeproj'
  common
end
