platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

## ------------------------- Pods ------------------------- ##

def firebasePods
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
end

def promisesPod
    pod 'PromisesSwift'
end

## ------------------------- Framework Targets ------------------------- ##

# iOS

target 'FirestoreClient iOS' do
    firebasePods
    promisesPod
  
    target 'FirestoreClient iOSTests' do
    end
end

# macOS

target 'FirestoreClient macOS' do
    platform :macos, '10.15'
    
    firebasePods
    promisesPod
  
    target 'FirestoreClient macOSTests' do
    end
end

# tvOS

target 'FirestoreClient tvOS' do
    platform :tvos, '10.0'
    
    firebasePods
    promisesPod
  
    target 'FirestoreClient tvOSTests' do
    end
end
