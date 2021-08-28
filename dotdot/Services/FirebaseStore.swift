//
//  FirebaseStore.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import Foundation
import FirebaseFirestore
import Firebase

let BASE_DATABASAE = Firestore.firestore()
class FirebaseStore{
    static let inst = FirebaseStore()
    private var _users_ref = BASE_DATABASAE.collection("users")
    private var _groups_ref = BASE_DATABASAE.collection("groups")
    private var _feed_ref = BASE_DATABASAE.collection("feeds")
    
    var users_CL : CollectionReference {
        return _users_ref
    }
    var groups_CL : CollectionReference {
        return _groups_ref
    }
    var feed_CL : CollectionReference {
        return _feed_ref
    }
    
    var feeds:[Message] = []
    var groups:[Group] = []
    var feedsDelegate:FeedsDelegate?
    var groupsDelegate:GroupsDelegate?
    
    func createDBUser(uid:String,data:Dictionary<String,Any>){
        users_CL.document(uid).setData(data)
    }
    
    func sendNewFeed(withMessage message:String,uid:String,groupId:String?,completion:(_ res:Bool)->()){
        if groupId == nil{
            feed_CL.addDocument(data: ["context":message,"senderId":uid,"population":Date()])
            completion(true)
        }else{
            groups_CL.document(groupId!).collection("messages").addDocument(data: ["context":message,"senderId":uid,"population":Date()])
            completion(true)
        }
    }
    
    func getEmail(fromUid uid:String,completion: @escaping (_ email:String)->()){
        users_CL.document(uid).getDocument { (document, error) in
            if let document = document , document.exists{
                let email = document.get("email") as! String
                completion(email)
            }else{
                completion("unknow@mail.com")
            }
        }
    }
    
    func loadDBFeeds(){
        feed_CL.order(by: "population").addSnapshotListener { querySnapshot, error in
            guard let data = querySnapshot?.documents else {return}
            self.feeds = []
            for i in 0..<data.count{
                let snapshot = data[i]
                let context = snapshot.get("context") as! String
                let senderId = snapshot.get("senderId") as! String
                let message = Message(context: context, senderId: senderId)
                self.getEmail(fromUid: senderId) { email in
                    message.senderEmail = email
                    self.feeds.append(message)
                    if i == data.count - 1 {
                        self.feedsDelegate?.feedsChanged()
                    }
                }
            }
        }
    }
    
    func searchForUser(withQueryText text:String,handler: @escaping (_ users:[String])->()){
        var users = [String]()
        users_CL.getDocuments { snapshot, error in
            guard let data = snapshot?.documents , error == nil else {
                debugPrint(error?.localizedDescription as Any)
                handler([])
                return
            }
            for user in data{
                let email = user.get("email") as! String
                if email.contains(text) && email != Firebase.Auth.auth().currentUser?.email{
                    users.append(email)
                }
            }
            print(users.joined(separator: ","))
            handler(users)
        }
    }
    
    func getUserIds(fromEmails emails:[String],handler: @escaping (_ ids:[String])->()){
        var userIds = [String]()
        users_CL.getDocuments { snapshot, error in
            guard let data = snapshot?.documents , error == nil else {
                debugPrint(error?.localizedDescription as Any)
                handler([])
                return
            }
            for user in data{
                let email = user.get("email") as! String
                if email.contains(email){
                    userIds.append(user.documentID)
                }
            }
            handler(userIds)
        }
    }
    
    func createGroup(withTitle title:String,andDescription description:String,forUserIds ids:[String],handler :@escaping (_ res:Bool)->()){
        groups_CL.addDocument(data: ["title":title,"description":description,"members":ids])
        handler(true)
    }
    
    func loadGroups(forUserId uid:String){
        groups_CL.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.documents , error == nil else {
                debugPrint(error?.localizedDescription as Any)
                return
            }
            self.groups = []
            for group in data{
                let title = group.get("title") as! String
                let desc = group.get("description") as! String
                let members = group.get("members") as! [String]
                let key = group.documentID
                if members.contains(uid){
                    self.groups.append(Group(title: title, description: desc, members: members, key: key))
                }
            }
            self.groupsDelegate?.groupsChanged()
        }
    }
    
    func getUserEmails(formUserIds ids:[String],handler : @escaping (_ emails:[String])->()){
        var userEmails = [String]()
        users_CL.getDocuments { snapshot, error in
            guard let data = snapshot?.documents , error == nil else {
                debugPrint(error?.localizedDescription as Any)
                handler([])
                return
            }
            for user in data{
                let email = user.get("email") as! String
                if ids.contains(user.documentID){
                    userEmails.append(email)
                }
            }
            handler(userEmails)
        }
    }
    
    func loadGroupMessages(forGroup group:Group,handler : @escaping (_ msgs:[Message])->()){
        groups_CL.document(group.key).collection("messages").order(by: "population").getDocuments { snapshot, error in
            var messages = [Message]()
            guard let messagesData = snapshot?.documents , error == nil else {
                debugPrint(error?.localizedDescription as Any)
                return
            }
            for message in messagesData {
                let context = message.get("context") as! String
                let senderId = message.get("senderId") as! String
                let message = Message(context: context, senderId: senderId)
                messages.append(message)
            }
            handler(messages)
        }
    }
}
