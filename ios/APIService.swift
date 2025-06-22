import Foundation

@objc(APIService)
class APIService: NSObject {
  @objc
  func getBundleMetaData(_ url: String, appId: String, completion: @escaping (Data?, Error?) -> Void) {
    guard let endpoint = URL(string: url) else {
      completion(nil, NSError(domain: "Not a valid URL Domain", code: 0, userInfo: nil))
      return
    }
    
    if appId == "" {
      completion(nil, NSError(domain: "No App ID Found", code: 0, userInfo: nil))
      return
    }
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    let jsonBody: [String: Any] = ["appID": appId]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
    } catch {
      completion(nil, error)
      return
    }

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }.resume()

  }
  
  @objc
  func downloadData(_ url: String, appId: String, completion: @escaping (URL?) -> Void) {
    guard let endpoint = URL(string: url) else {
      completion(nil)
      return
    }
    
    if appId == "" {
      completion(nil)
      return
    }
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    let jsonBody: [String: Any] = ["appID": appId, "platform": "ios"]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
    } catch {
      completion(nil)
      return
    }

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.downloadTask(with: request) { (downloadedURL, _, error) in
      guard let tempURL = downloadedURL, error == nil else {
            print("Download error:", error ?? "")
            completion(nil)
            return
      }
      completion(tempURL)
      return
    }.resume()
  }
}

