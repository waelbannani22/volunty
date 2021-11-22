//
//  Recruiter.swift
//  volunty
//
//  Created by wael bannani on 20/11/2021.
//

import Foundation
class Recruiter {
    private var _name :String = ""
   
    private var _email :String = ""
    private var _password :String = ""
    private var _photo :String = ""
    private var _phone :String = ""
  
    private var _description :String = ""
    private var _organisation : String = ""
   

    
    var name: String{
        return _name
    }
    var phone: String{
        return _phone
    }
    var email: String{
        return _email
    }
    var password: String{
        return _password
    }
    var photo :String{
        return _photo
    }
    var organisation: String{
        return _organisation
    }
    
    var description: String{
        return _description
    }
    init (name :String,phone :String,email :String,photo:String,password:String,organisation:String,description:String){
        
        self._name = name
        self._phone = phone
        self._email = email
        self._photo = photo
        self._organisation = organisation
        self._description = description
        
    }
    
}
