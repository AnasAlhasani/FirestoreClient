Pod::Spec.new do |s|
  s.name         = 'FirestoreClient'
  s.version      = '0.1.0'
  s.summary      = 'Abstraction layer on top of Firebase database'
  s.homepage     = 'https://github.com/AnasAlhasani/FirestoreClient'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Anas Alhasani'
  s.source       = { :git => 'https://github.com/AnasAlhasani/FirestoreClient.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AlhasaniAnas'
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.1'
  s.requires_arc     = true
  s.static_framework = true
  s.source_files = 'Sources/FirestoreClient'
  s.frameworks   = 'Foundation'
  s.dependency     'Firebase/Core'
  s.dependency     'Firebase/Firestore'
  s.dependency     'FirebaseFirestoreSwift'
  s.dependency     'PromisesSwift'
end
