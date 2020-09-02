use_frameworks!
platform :ios, '10.0'

workspace 'Monolith'

def common
  pod 'Swinject'
end

target 'MainApplication' do
  project 'MainApplication/MainApplication.xcodeproj'
  common
end

target 'Repository' do
  project 'Repository/Repository.xcodeproj'
  common
end

target 'Networking' do
  project 'Networking/Networking.xcodeproj'
  common
end
