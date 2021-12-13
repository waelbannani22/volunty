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
    func postingcall(token :String,name:String,city:String,dateBegin:String,description:String,recruiter:String,ageGroupe:String,category:String,photo:UIImage,completionHandler: @escaping HandlerHomeV){
        
        let imgData = photo.jpegData(compressionQuality: 0.2)!
        

        
        let para :[String: Any] = [
            "name":name,
            "token":token,
            "city":city,
            "dateBegin":dateBegin,
            "description":description,
            "recruiter":recruiter,
            "ageGroup":ageGroupe,
            "category":category,
            "photo":imgData
            
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
    func postingcall1(token :String,name:String,city:String,dateBegin:String,description:String,recruiter:String,ageGroupe:String,category:String,photo:UIImage,completionHandler: @escaping HandlerHomeV){
        
       

        
        let para :[String: Any] = [
            "name":name,
            "token":token,
            "city":city,
            "dateBegin":dateBegin,
            "description":description,
            "recruiter":recruiter,
            "ageGroup":ageGroupe,
            "category":category,
            
            
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(photo.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
                for (key, value) in para {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    } //Optional for extra parameters
            },
                         to:"http://localhost:3000/create_call",method: .post,headers: headers )
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
    func accept(callId:String,idv:String,name:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "callId":callId,
            "idv":idv,
            "name":name
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
    func decline(callId:String,idv:String,name:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "callId":callId,
            "idv":idv,
            "name": name
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/FetchPostsByIDVDecline", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
            response  in
            //debugPrint(response)
            if let status =  response.response?.statusCode{
                let data = response.data
            
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
    
    func removecall(callId:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "id":callId
           
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/delete_call", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
    func addDonation(recruiterId:String,name:String,location:String,organisation:String,deadline:String,phone:String,photo:UIImage,montantTotal:String,description:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
    
            "recruiterId":recruiterId,
            "organisation":organisation,
            "name": name,
            "location":location,
            "deadline":deadline,
            "phone":phone,
           
            "description":description,
            "montantTotal":montantTotal
        ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(photo.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
                for (key, value) in para {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    } //Optional for extra parameters
            },
                         to:"http://localhost:3000/addDonation",method: .post,headers: headers )
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
    func fetchDonation(recruiterId:String,completionHandler: @escaping HandlerHomeV){
        
        let para :[String: Any] = [
           
            "id":recruiterId
       ]
        let headers :HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("http://localhost:3000/fetchDonationByRecruiter", method: .post,parameters: para,encoding: JSONEncoding.default,headers: headers).response {
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
    
    
}
