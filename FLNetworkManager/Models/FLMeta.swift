import SwiftyJSON

public struct FLMeta {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let kFLMetaStatusKey: String = "status"
    private let kFLMetaMessageKey: String = "message"
    
    // MARK: Properties
    public var status: Bool = false
    public var message: String?
    
    // MARK: SwiftyJSON Initalizers
    /**
     Initates the instance based on the object
     - parameter object: The object of either Dictionary or Array kind that was passed.
     - returns: An initalized instance of the class.
     */
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /**
     Initates the instance based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init(json: JSON) {
        status = json[kFLMetaStatusKey].boolValue
        message = json[kFLMetaMessageKey].string
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[kFLMetaStatusKey] = status
        if let value = message { dictionary[kFLMetaMessageKey] = value }
        return dictionary
    }
    
}
