
import Foundation
import React

struct BundleHash: Codable{
  let bundleHashCode: String
}

struct BundleHashResponse: Codable {
  let data: BundleHash
}



@objc(OTABundleManager)
class OTABundleManager: NSObject {
  
  let apiService: APIService
  override init(){
    self.apiService = APIService()
  }
  
  private func compareBundleHashCode(currentBundleHashCode : String, serverBundleHashCode : String) -> Bool {
    return currentBundleHashCode != serverBundleHashCode
  }
  
  private func downloadBundle(apiEndpoint: String, appId: String, newBundleHashCode: String, completion: @escaping RCTPromiseResolveBlock) {
    self.apiService.downloadData(apiEndpoint, appId: appId, completion: { (dataUrl) in
      guard let path = dataUrl else {
        return
      }

      let fileManager = FileManager.default
      let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
      let destPath = documents.appendingPathComponent("main.jsbundle")

      do {
        if fileManager.fileExists(atPath: destPath.path) {
          try fileManager.removeItem(at: destPath)
        }

        try fileManager.copyItem(at: path, to: destPath)
        UserDefaults.standard.set(newBundleHashCode, forKey: "currentBundleHashCode")
        completion(true)
        
      } catch {
        print(error)
        completion(false)
      }
    })
  }
    
  
  
  @objc
  func checkForBundleUpdate(_ apiEndpoint: String, appId: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    self.apiService.getBundleMetaData(apiEndpoint, appId: appId, completion:  { (data, error) in
      if (error != nil) {
        resolver(false)
        return
      }
      do {
        let hashResponse = try JSONDecoder().decode(BundleHashResponse.self, from: data!)
        let currentBundleHashCode = "22"
//        UserDefaults.standard.string(forKey: "currentBundleHashCode") ?? ""
        print("Hashcode:", currentBundleHashCode, hashResponse.data.bundleHashCode)
        let isUpdateNeeded = self.compareBundleHashCode(currentBundleHashCode: currentBundleHashCode, serverBundleHashCode: hashResponse.data.bundleHashCode)
        if (isUpdateNeeded) {
          self.downloadBundle(apiEndpoint: "http://localhost:8008/bundle", appId: appId, newBundleHashCode: hashResponse.data.bundleHashCode, completion: resolver)
          return
        } else {
          resolver(false)
          return
        }
      } catch {
        resolver(false)
        return
      }
      
    
    })
  }
}

