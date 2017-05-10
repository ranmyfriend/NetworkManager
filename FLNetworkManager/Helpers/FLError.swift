//
//  NetworkErrorPlugin.swift
//  F22Labs
//
//  Created by Ranjith Kumar on 27/04/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

enum HudPosition {
    case top,bottom
}

enum HudBgColor {
    case red,blue,gray
}

struct HudInfo {
    var bg_color:HudBgColor?
    var position:HudPosition?
}

public struct FLError<A> {
    var code:Int?
    var message:String?
    var status:Bool?
    var typeToShow:A?
    
    public init(code:Int,message:String,typeToShow:A,status:Bool) {
        self.code = code
        self.message = message
        self.typeToShow = typeToShow
        self.status = status
    }
    
    static func buildError<T>(input:T)->Any {
        var plugin:Any? = nil
        if input is FLMeta {
            let meta = input as! FLMeta
            let h_info = HudInfo.init(bg_color: (meta.status ? .red : .blue), position: .top)
            plugin = FLError<HudInfo>.init(code: 200, message: meta.message!, typeToShow: h_info,status:meta.status)
        }else {
            let error = input as! NSError
            if FLErrorJSON.list?.keys.contains(String(error.code)) == false {
                let h_info = HudInfo.init(bg_color: .red, position: .top)
                plugin = FLError<HudInfo>.init(code: error.code, message: error.localizedDescription, typeToShow: h_info,status: false)
            }else {
                let h_info = HudInfo.init(bg_color: .red, position: .top)
                let code = String(error.code)
                plugin = FLError<HudInfo>.init(code: error.code, message: (FLErrorJSON.list?[code])! as! String, typeToShow:h_info,status: false)
            }
        }
        return plugin!
    }
}
