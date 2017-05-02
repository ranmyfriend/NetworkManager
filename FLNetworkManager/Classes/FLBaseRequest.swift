//
//  FLBaseRequest.swift
//  Pods
//
//  Created by Ranjith Kumar on 03/05/2017.
//
//

import Foundation
import Alamofire

protocol RequestProtocol {
    var path        : String            { get }
    var method      : HTTPMethod        { get }
    var parameters  : [String: Any]?    { get }
    var headers     : [String: String]? { get }
}

open class BaseRequest:RequestProtocol {
    open var path: String { return "" }
    open var method: HTTPMethod { return .get }
    open var parameters: [String : Any]? { return [:] }
    open var headers: [String : String]? { return [:] }
    open var requestType: Any? { return self }
    
    public init() {}
}
