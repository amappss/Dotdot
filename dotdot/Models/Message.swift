//
//  Message.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import Foundation

class Message {
    private var _content:String
    private var _senderId:String
    var senderEmail = ""
    
    var context:String{
        return _content
    }
    
    var senderId:String {
        return _senderId
    }
    
    init(context:String,senderId:String) {
        _content = context
        _senderId = senderId
    }
    
}
