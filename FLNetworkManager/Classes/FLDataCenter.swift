//
//  FLDataCenter.swift
//  Pods
//
//  Created by Ranjith Kumar on 02/05/2017.
//
//

import Foundation
import Alamofire
import SwiftyJSON

public enum AsyncResult<T> {
    case success(T)
    case failure(Any)
}

public protocol NetworkDispatcher {
    func execute(request: BaseRequest,completion:@escaping (AsyncResult<Any>)->())
}

open class FLDataCenter:NetworkDispatcher {
    
    open var baseDomain: String? = nil
    open var timeOutInterval: Double = 30.0
    
    private var sessionManager:SessionManager?
    
    class var sharedInstance: FLDataCenter {
        struct Static {
            static let instance: FLDataCenter = FLDataCenter()
        }
        return Static.instance
    }
    
   private func setupConfig() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(self.timeOutInterval)
        configuration.timeoutIntervalForResource = TimeInterval(self.timeOutInterval)
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
   open func setBaseDomain(domain:String) {
        self.baseDomain = domain;
        self.setupConfig()
    }
    
   open func execute(request: BaseRequest, completion: @escaping (AsyncResult<Any>) -> ()) {
        let endURL = baseDomain?.appending(request.path)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API")
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("\(request.method) Request ---> \(String(describing: url))")
        self.sessionManager?.request(url, method: request.method, parameters: nil, encoding: JSONEncoding.default, headers: request.headers).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let json = JSON(response.result.value!)[StringConstants.responseKey]
                completion(AsyncResult.success(json))
                break
            case .failure(_):
                completion(AsyncResult.failure(response.result.error!))
            }
        }
    }
    
   open func executeMulti_Part(request: BaseRequest, completion: @escaping (AsyncResult<Any>) -> ()) {
        let endURL = baseDomain?.appending(request.path)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        guard let imageKey = request.parameters?["imageKey"], (imageKey as! String).isEmpty == false else { return }
        guard let imageName = request.parameters?["imageName"], (imageName as! String).isEmpty == false else { return }
        guard let mimeType = request.parameters?["mimeType"], (mimeType as! String) == "image/jpeg" else { return }
        
        debugPrint("POST MULTIPART Request ---> \(String(describing: url))")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.sessionManager?.upload(multipartFormData: { (multipartData) in
            if let data = UIImageJPEGRepresentation(request.parameters?["image"] as! UIImage, 1) {
                multipartData.append(data, withName:imageName as! String, mimeType:mimeType as! String)
            }
            request.parameters?.forEach({ (key,value) in
                multipartData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            })
        }, to: url, encodingCompletion: { (encodingResult) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    let json = JSON(response.result.value!)[StringConstants.responseKey]
                    completion(AsyncResult.success(json))
                }
            case .failure(let error):
                completion(AsyncResult.failure(error))
            }
        })
    }
}
