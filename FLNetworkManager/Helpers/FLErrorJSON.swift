import UIKit

class FLErrorJSON {
    static let list = { () -> [String:Any]? in
        let url = Bundle.main.url(forResource: "ErrorCodes", withExtension: "json")
        let d = try! Data.init(contentsOf: url!)
        var sErrorCodes:[String:Any]? = nil
        do {
            sErrorCodes = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [String:Any]
            debugPrint(sErrorCodes as Any)
        } catch {
            debugPrint(error)
        }
        return sErrorCodes
    }()
}
