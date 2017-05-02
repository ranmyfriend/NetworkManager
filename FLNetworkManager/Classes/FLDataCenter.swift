//
//  FLDataCenter.swift
//  Pods
//
//  Created by Ranjith Kumar on 02/05/2017.
//
//

import Foundation
import UIKit

import Alamofire

enum AsyncResult<T> {
    case success(T)
    case failure(Any)
}

typealias returnBlock = (URLResponse?, AnyObject?, Error?) -> Void

class FLDataCenter: NSObject,FLDataCenterProtocol {
    
    open var baseDomain: String? = nil
    open var timeOutInterval: Double = 30.0
    
    fileprivate var sessionManager:SessionManager?
    
    class var sharedInstance: FLDataCenter {
        struct Static {
            static let instance: FLDataCenter = FLDataCenter()
        }
        return Static.instance
    }
    
    func setupConfig() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(self.timeOutInterval)
        configuration.timeoutIntervalForResource = TimeInterval(self.timeOutInterval)
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func setBaseDomain(domain:String) {
        self.baseDomain = domain;
        self.setupConfig()
    }
    
    func GET(connectingURL:String,ReturnBlock:@escaping returnBlock) {
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("GET Request ---> \(String(describing: url))")
        self.sessionManager?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: self.headers()).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let data = response.result.value as AnyObject
                guard let resp = response.response else{
                    ReturnBlock(nil,data,nil)
                    return
                }
                ReturnBlock(resp,data,nil)
                break
            case .failure(_):
                guard let error = response.result.error else{
                    ReturnBlock(nil,nil,nil)
                    return
                }
                ReturnBlock(nil,nil,error)
                break
            }
        }
    }
    
    func POST(connectingURL:String,
              parameters:Dictionary<String,Any>?,
              ReturnBlock:@escaping returnBlock) {
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("POST Request ---> \(String(describing: url))")
        self.sessionManager?.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let data = response.result.value
                ReturnBlock(response.response!,data as AnyObject?,nil)
                break
            case .failure(_):
                guard let error = response.result.error else{
                    ReturnBlock(nil,nil,nil)
                    return
                }
                ReturnBlock(nil,nil,error)
                break
            }
        }
    }
    
    func PUT(connectingURL:String,
             parameters:Dictionary<String,Any>?,
             ReturnBlock:@escaping returnBlock) {
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("PUT Request ---> \(String(describing: url))")
        self.sessionManager?.request(endURL!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let data = response.result.value
                ReturnBlock(response.response!,data as AnyObject?,nil)
                break
            case .failure(_):
                guard let error = response.result.error else{
                    ReturnBlock(nil,nil,nil)
                    return
                }
                ReturnBlock(nil,nil,error)
                break
            }
        }
    }
    
    func DELETE(connectingURL:String,
                parameters:Dictionary<String,Any>?,
                ReturnBlock:@escaping returnBlock) {
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("DELETE Request ---> \(String(describing: url))")
        self.sessionManager?.request(endURL!, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let data = response.result.value
                ReturnBlock(response.response!,data as AnyObject?,nil)
                break
            case .failure(_):
                guard let error = response.result.error else{
                    ReturnBlock(nil,nil,nil)
                    return
                }
                ReturnBlock(nil,nil,error)
                break
            }
        }
    }
    
    func PATCH(connectingURL:String,
               parameters:Dictionary<String,Any>?,
               ReturnBlock:@escaping returnBlock) {
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint("PATCH Request ---> \(String(describing: url))")
        self.sessionManager?.request(endURL!, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseJSON{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                let data = response.result.value
                ReturnBlock(response.response!,data as AnyObject?,nil)
                break
            case .failure(_):
                guard let error = response.result.error else{
                    ReturnBlock(nil,nil,nil)
                    return
                }
                ReturnBlock(nil,nil,error)
                break
            }
        }
    }
    
    func POST(connectingURL:String,
              image:UIImage,
              imageName:String,
              imageKey:String,
              mimeType:String,
              parameters:Dictionary<String,Any>?,
              ReturnBlock:@escaping returnBlock) {
        var mimeType = mimeType
        var imageKey = imageKey
        var imageName = imageName
        
        let endURL = baseDomain?.appending(connectingURL)
        guard let url = endURL, url.isEmpty == true else {
            debugPrint("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return
        }
        if imageKey.isEmpty == false { imageKey = "image" }
        if imageName.isEmpty == false { imageName = "image" }
        if mimeType.isEmpty == false { mimeType = "image/jpeg" }
        debugPrint("POST MULTIPART Request ---> \(String(describing: url))")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.upload(multipartFormData: {multipartData in
            // import image to request
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                multipartData.append(imageData, withName: imageName, mimeType: mimeType)
            }
            // import parameters
            for (key, value) in parameters! {
                multipartData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: endURL!, encodingCompletion: {encodingResult in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    ReturnBlock(response.response!,response.data as AnyObject?,nil)
                }
            case .failure(let encodingError):
                debugPrint(encodingError)
                ReturnBlock(nil,nil,encodingError)
            }
        })
    }
}

extension FLDataCenter {
    fileprivate func headers() -> Dictionary<String,String> {
        var headers = [String:String]()
        headers["Accept"] = "application/json"
        headers["Content-type"] = "application/json"
        return headers
    }
    
}
