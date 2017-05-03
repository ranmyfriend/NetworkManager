//
//  RootViewController.swift
//  FLNetworkManager
//
//  Created by Ranjith Kumar on 02/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import FLNetworkManager
import SwiftyJSON

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func callMe() {
        let request = LoginRequest()
        FLDataCenter.shared.execute(request: request) { (result) in
            switch result {
            case .success(let json):
                let bc = FLResponse<LoginModel>(json:json,
                                                       resp:LoginModel.init(json: json["response"]))
                if bc.meta?.status == true {
                }else {
                    if let _ = bc.meta?.message {
                        
//                        self.showErrorHud(position: .top, message:msg , bgColor: .red, isPermanent: false)
                    }
                }
                break
            case .failure(let error):
                print(error)
//                self.showErrorHud(position: .top, message: (error?.localizedDescription)!, bgColor: .red, isPermanent:false)
                break
            }
        }
    }
}

class LoginModel {
    public init(json: JSON) {
    }
}

class LoginRequest:BaseRequest {
    override var path: String {
        return "/Login"
    }
    override var parameters: [String : Any] {
        return [:]
    }
    override var headers: [String : String] {
        return [:]
    }
}

