//
//  RootViewController.swift
//  FLNetworkManager
//
//  Created by Ranjith Kumar on 02/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import FLNetworkManager

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


class LoginModel{}

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

