//
//  loginViewModel1.swift
//  volunty
//
//  Created by wael bannani on 25/11/2021.
//

import Foundation
import Alamofire
import AVFoundation
enum APIErrors : Error{
    case custom(message : String)
}
struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

typealias Handler = (Swift.Result<Any?,APIErrors>) -> Void
class LoginViewModel1 {
    static let instance = LoginViewModel1()
    
    func callingLoginAPI(email :String, password: String,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "email":email,
            "password":password
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/login", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
    func callingSignUpAPI(email :String, password: String, username: String, lastname: String
                          , age: String, phone: String
                          ,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "email":email,
            "password":password,
            "username":username,
            "lastname":lastname,
            "age":age,
            "phone":phone,
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/Signup", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
           // debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        print(" jsonnn",json)
                        completionHandler(.success(json))
                    
                        print(json)
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
        
    }
    func verifmail(email :String
                          ,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "email":email,
           
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/sendmail", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
           // debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        print(" jsonnn",json)
                        completionHandler(.success(json))
                    
                        print(json)
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
        
    }
    func verifcode(codePassed :String,code :String
                          ,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "password":code,
           
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/h/\(codePassed)/", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
           // debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                       
                        completionHandler(.success("success"))
                    
                       
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
        
    }
    func changepassword(userId :String,password:String,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "password":password,
           
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/g/\(userId)/", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
           // debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                       
                        completionHandler(.success("success"))
                    
                       
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                    
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
            
        }
        
        
    }
    func callingLoginRecruiterAPI(email :String, password: String,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "email":email,
            "password":password
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/loginRecruiter", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
    //signuprecruiter
    func callingSignUpRecruiterAPI(email :String, password: String, name: String, description: String
                          , organisation: String, phone: String
                          ,completionHandler: @escaping Handler){
        let para :[String: Any] = [
            "email":email,
            "password":password,
            "name":name,
            "description":description,
            "organisation":organisation,
            "phone":phone,
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:8885/SignupRecrruiter", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
           // debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                       
                        completionHandler(.success("success"))
                    
                       // print("success")
                        
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
