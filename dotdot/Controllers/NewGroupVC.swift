//
//  NewGroupVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/6/21.
//

import UIKit
import Firebase
class NewGroupVC: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var descriptionField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var emailsTbl: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    
    var chosenUsers = [String]()
    var foundUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailsTbl.dataSource = self
        emailsTbl.delegate = self
        emailField.delegate = self
        emailField.addTarget(self, action: #selector(emailFieldTextChanged), for: .editingChanged)
    }
    @IBAction func clsoePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func donePressed(_ sender: Any) {
        guard let title = titleField.text,let description = descriptionField.text,title != "",description != "" else { return }
        FirebaseStore.inst.getUserIds(fromEmails: chosenUsers) { ids in
            var userIds = ids
            userIds.append(Firebase.Auth.auth().currentUser!.uid)
            FirebaseStore.inst.createGroup(withTitle: title, andDescription: description, forUserIds: userIds) { res in
                if res {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func emailFieldTextChanged(){
        guard let text = emailField.text  else { return }
        if text == ""{
            foundUsers = []
            emailsTbl.reloadData()
        } else {
            FirebaseStore.inst.searchForUser(withQueryText: text) { users in
                self.foundUsers = users
                self.emailsTbl.reloadData()
            }
        }
    }
            
}

extension NewGroupVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell{
            if chosenUsers.contains(foundUsers[indexPath.row]){
                cell.setupCell(email: foundUsers[indexPath.row], isSelected: true)
            } else {
                cell.setupCell(email: foundUsers[indexPath.row], isSelected: false)
            }
            return cell
        } else {
            return UserCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let email = foundUsers[indexPath.row]
        if chosenUsers.contains(email){
            chosenUsers = chosenUsers.filter({$0 != email})
            if chosenUsers.count > 0 {
                emailLbl.text = chosenUsers.joined(separator: ", ")
            } else {
                emailLbl.text = "Enter user's email to add"
            }
        }else{
            chosenUsers.append(email)
            emailLbl.text = chosenUsers.joined(separator: ", ")
        }
    }
    
    
}
