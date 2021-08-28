//
//  Group.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/7/21.
//

import Foundation

class Group {
    private var _title : String
    private var _description : String
    private var _members : [String]
    private var _key :String
    
    var title :String {
        return _title
    }
    var description :String{
        return _description
    }
    var members :[String]{
        return _members
    }
    var key :String{
        return _key
    }
    
    init(title:String,description:String,members:[String],key:String) {
        _title = title
        _description = description
        _members = members
        _key = key
    }
    
}
