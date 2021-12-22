//
//  loginViewModel1.swift
//  volunty
//
//  Created by wael bannani on 25/11/2021.
//

import Foundation
import Alamofire
import AVFoundation
import UIKit
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
    
    func callingFetchHome(email :String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "email":email
           
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
    func updateUser(id : String,token : String,username : String,lastname :String,photo:UIImage,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
            "token":token,
            "username":username,
            "lastname":lastname,
            "photo":photo
          
        ]
        print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(photo.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
                for (key, value) in para {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    } //Optional for extra parameters
            },
                         to:"http://localhost:3000/update_volunteer",method: .post,headers: headers )
        { result in
          
            
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseJSON { response in
                    let status = response.response?.statusCode
                    switch status{
                    case 200 :
                        print(response.response?.statusCode)
                        completionHandler(.success("success"))
                    case 400 :
                        print(response.response?.statusCode)
                        completionHandler(.failure(.custom(message: "failed")))
                   
                    case .none:
                        completionHandler(.failure(.custom(message: "failed")))
                    case .some(_):
                        completionHandler(.success("success"))
                    }
                   
                }

            case .failure(let encodingError):
                print(encodingError)
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
                }}
             }
   
}
    func fetchbyUser(id : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchUserById", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                }}
            
        }
}
    func createVolunteerCall(id : String,callId : String,username:String,lastname:String,email:String,age:String,memberDate:String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "idV":id,
            "callId":callId,
            "username":username,
            "lastname":lastname,
            "email":email,
            
            "age":age,
            "memberDate":memberDate
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/VolunteerCall", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                }}
            
        }
}
    func fetchNotification(id : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchNotificationById", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                }}
            
        }
}
    func fetchReview(id : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchReviewById", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                }}
            
        }
}
    func fetchbyFB(fbid : String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "fbid":fbid,
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchUserEmail", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                }}
            
        }
}
    func addReview(id : String,name:String,idv:String,desc:String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "id":id,
            "name":name,
            "idv":idv,
            "desc":desc
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/addReview", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            debugPrint(response)
            if let status =  response.response?.statusCode{
               // let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                       // let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(.success(status))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                case 400 :
                    completionHandler(.failure(.custom(message: "already added")))
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }}
            
        }
}
    func addVB(name : String,last:String,email:String,picture:String,fbid:String,completionHandler: @escaping HandlerHomeV){
        let para :[String: Any] = [
            "last":last,
            "name":name,
            "email":email,
            "picture":picture,
            "id":fbid
         ]
       // print(para)
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/createVolunteerFB", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
                case 400 :
                    completionHandler(.failure(.custom(message: "already added")))
                    
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }}
            
        }
}
}
