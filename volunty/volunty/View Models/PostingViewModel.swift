//
//  PostingViewModel.swift
//  volunty
//
//  Created by wael bannani on 28/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostingViewModel {
    static let instance = PostingViewModel()
    func postingcall(token :String,name:String,city:String,dateBegin:String,description:String,recruiter:String,ageGroupe:String,category:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
            "name":name,
            "token":token,
            "city":city,
            "dateBegin":dateBegin,
            "description":description,
            "recruiter":recruiter,
            "ageGroup":ageGroupe,
            "category":category
            
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/create_call", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
          //  debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
                print(status)
                switch status {
                    case 200:
                    do {
                        
                       // let json =  try JSONSerialization.jsonObject(with: data!, options: [])
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
    func FetchPostsByRecruiter(token :String,recruiter:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
           
            "token":token,
          
            "id":recruiter,
         
            
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/FetchPostsByRecruiter", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            //debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
              //  print(status)
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
    func FetchPostsBycallId(callId:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
           
            
          
            "callId":callId
         
            
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/FetchPostsById", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            //debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
              //  print(status)
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
    func accept(callId:String,idv:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "callId":callId,
            "idv":idv
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/FetchPostsByIDVACCEPT", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            //debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
              //  print(status)
                switch status {
                    case 200:
                    do {
          
                        completionHandler(.success("json"))
                        
                    } catch  {
                        completionHandler(.failure(.custom(message: "failed")))
                    }
                  
                default:
                   
                    completionHandler(.failure(.custom(message: "please try again")))
                }
                    
                }
        
    }
}
    func decline(callId:String,idv:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "callId":callId,
            "idv":idv
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/FetchPostsByIDVDecline", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            //debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
              //  print(status)
                switch status {
                    case 200:
                    do {
          
                        completionHandler(.success("json"))
                        
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
