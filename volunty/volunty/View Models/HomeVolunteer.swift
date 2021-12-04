//
//  loginViewModel1.swift
//  volunty
//
//  Created by wael bannani on 25/11/2021.
//

import Foundation
import Alamofire
import AVFoundation
enum FetchError : Error{
    case custom(message : String)
}
struct FetchResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

typealias HandlerHomeV = (Swift.Result<Any?,FetchError>) -> Void
class HomeVolunteer {
    static let instance = HomeVolunteer()
    
    func callingFetchHome(email :String, token: String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "email":email,
            "token":token
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/volunteers", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(json))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
        
    }
    func resetpassword(email : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "email":email
          
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/resetpassword", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(json))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
    }
    func resetpassword2(user : String,token : String,password : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "password":password
          
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/\(user)/\(token)", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(json))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
    }
    func updateUser(id : String,token : String,username : String,lastname :String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
            "token":token,
            "username":username,
            "lastname":lastname
          
        ]
        print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/update_volunteer", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                       // let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(status))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
    }
    func fetchByCategory(category : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "category":category,
        
        ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchByCategory", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(json))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
    }
    
   
   
}
