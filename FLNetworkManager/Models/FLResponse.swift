import SwiftyJSON

public struct FLResponse<T> {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let kFLResponseMetaKey: String = "meta"
    private let kFLResponseResponseKey: String = "response"
    
    // MARK: Properties
    public var meta: FLMeta?
    var error: Any?
    public var response: T?
    
    // MARK: SwiftyJSON Initalizers
    /**
     Initates the instance based on the object
     - parameter object: The object of either Dictionary or Array kind that was passed.
     - returns: An initalized instance of the class.
     */
    public init(object: Any, resp:T) {
        self.init(json: JSON(object),resp:resp)
    }
    
    /**
     Initates the instance based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init(json: JSON, resp:T) {
        meta = FLMeta(json: json[kFLResponseMetaKey])
        error = FLError<FLMeta>.buildError(input: meta)
        response = resp
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = meta { dictionary[kFLResponseMetaKey] = value.dictionaryRepresentation() }
        if response != nil { dictionary[kFLResponseResponseKey] = response.flatMap({$0}) }
        return dictionary
    }
}
