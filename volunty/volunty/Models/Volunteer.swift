//
//  Volunteer.swift
//  volunty
//
//  Created by wael bannani on 20/11/2021.
//

import Foundation

class Volunteer :  Decodable{
    private var _name :String = ""
    private var _lastname :String = ""
    private var _email :String = ""
    private var _password :String = ""
    private var _photo :String = ""
    private var _memberDate :String = ""
    private var _age :Int = 0
    private var _description :String = ""
    
    var name: String{
        return _name
    }
    var lastname: String{
        return _lastname
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
    var memberDate: String{
        return _memberDate
    }
    var age: Int{
        return _age
    }
    var description: String{
        return _description
    }
    init (name :String,lastname :String,email :String,photo:String,password:String,memberDate:String,age:Int,description:String){
        
        self._name = name
        self._lastname = lastname
        self._email = email
        self._photo = photo
        self._memberDate = memberDate
        self._age = age
        self._description = description
        
    }
    
}

       
