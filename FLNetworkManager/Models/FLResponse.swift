//
//  PWBaseResponse.swift
//
//  Created by Chandrachudh on 26/04/17
//  Copyright (c) F22Labs. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PWBaseResponse<A> {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let kPWBaseResponseMetaKey: String = "meta"
    private let kPWBaseResponseResponseKey: String = "response"
    
    // MARK: Properties
    public var meta: PWMeta?
    var plugin: Any?
    public var response: A?
    
    // MARK: SwiftyJSON Initalizers
    /**
     Initates the instance based on the object
     - parameter object: The object of either Dictionary or Array kind that was passed.
     - returns: An initalized instance of the class.
     */
    public init(object: Any, resp:A) {
        self.init(json: JSON(object),resp:resp)
    }
    
    /**
     Initates the instance based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init(json: JSON, resp:A) {
        meta = PWMeta(json: json[kPWBaseResponseMetaKey])
        plugin = NetworkErrorPlugin<PWMeta>.buildErrorPlugin(input: meta)
        response = resp
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = meta { dictionary[kPWBaseResponseMetaKey] = value.dictionaryRepresentation() }
        //    if let value = response { dictionary[kPWBaseResponseResponseKey] = value.dictionaryRepresentation() }
        if response != nil { dictionary[kPWBaseResponseResponseKey] = response.flatMap({$0}) }
        return dictionary
    }
    
}
