//
//  FLDataCenterProtocol.swift
//  Pods
//
//  Created by Ranjith Kumar on 02/05/2017.
//
//

import Foundation

protocol FLDataCenterProtocol {
    
    func GET(connectingURL:String,ReturnBlock:@escaping returnBlock)
    
    func POST(connectingURL:String,
              parameters:Dictionary<String,Any>?,
              ReturnBlock:@escaping returnBlock)
    
    func PUT(connectingURL:String,
             parameters:Dictionary<String,Any>?,
             ReturnBlock:@escaping returnBlock)
    
    func DELETE(connectingURL:String,
                parameters:Dictionary<String,Any>?,
                ReturnBlock:@escaping returnBlock)
    
    func PATCH(connectingURL:String,
               parameters:Dictionary<String,Any>?,
               ReturnBlock:@escaping returnBlock)
    
    func POST(connectingURL:String,
              image:UIImage,
              imageName:String,
              imageKey:String,
              mimeType:String,
              parameters:Dictionary<String,Any>?,
              ReturnBlock:@escaping returnBlock)
    
}
