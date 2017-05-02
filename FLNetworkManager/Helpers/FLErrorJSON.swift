class FLErrorJSON {
    static let list = { () -> [String:Any]? in
        let url = Bundle.main.url(forResource: "ErrorCodes", withExtension: "json")
        let data = try! Data.init(contentsOf: url!)
        var sErrorCodes:[String:Any]? = nil
        do {
            sErrorCodes = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
        } catch {
            debugPrint(error)
        }
        return sErrorCodes
    }()
}
