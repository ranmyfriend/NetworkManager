//
//  RootViewController.swift
//  FLNetworkManager
//
//  Created by Ranjith Kumar on 02/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LoginRequest.doLogin(params: ["email":"ranjit@gmail.com","password":"12345"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


