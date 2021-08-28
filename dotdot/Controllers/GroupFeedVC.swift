//
//  GroupFeedVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/7/21.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {

    @IBOutlet weak var feedTbl:UITableView!
    @IBOutlet weak var sendMsgView:UIView!
    @IBOutlet weak var membersLbl:UILabel!
    @IBOutlet weak var messageField: CustomTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    var group:Group!
    var groupEmailsDic = Dictionary<String,String>()
    var messages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTbl.dataSource = self
        feedTbl.delegate = self
        
        sendMsgView.bindToKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        FirebaseStore.inst.getUserEmails(formUserIds: group.members) { emails in
            for i in 0..<emails.count{
                self.groupEmailsDic[self.group.members[i]] = emails[i]
            }
            DispatchQueue.main.async {
                self.membersLbl.text = self.groupEmailsDic.values.joined(separator: ", ")
            }
            FirebaseStore.inst.groups_CL.document(self.group.key).collection("messages").addSnapshotListener { _, _ in
                FirebaseStore.inst.loadGroupMessages(forGroup: self.group) { messages in
                    self.messages = messages
                    if self.messages.count > 0 {
                        self.feedTbl.reloadData()
                        self.feedTbl.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .none, animated: true)
                    }
                }
            }
           
        }
    }
    
    func initGroupFeedVC(group:Group){
        self.group = group
    }
    
    @IBAction func closePressed(sender:Any){
        dismissDetail()
    }

    @IBAction func sendPressed(_ sender: Any) {
        guard let message = messageField.text , messageField.text != "" else { return }
        messageField.isEnabled = false
        sendBtn.isEnabled = false
        FirebaseStore.inst.sendNewFeed(withMessage: message, uid: Firebase.Auth.auth().currentUser!.uid, groupId: group.key) { complete in
            if complete {
                messageField.text = ""
                messageField.isEnabled = true
                sendBtn.isEnabled = true
                messageField.endEditing(true)
            }
        }
    }
    
}

extension GroupFeedVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell{
            let message = messages[indexPath.row]
            cell.setupView(email: groupEmailsDic[message.senderId] ?? "", message: message.context)
            return cell
        } else {
            return FeedCell()
        }
    }
    
    
}
