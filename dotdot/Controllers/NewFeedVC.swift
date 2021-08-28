//
//  newFeedVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit
import Firebase
class NewFeedVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    var isSendingMessage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.isEnabled = false
        messageTextView.delegate = self
        
        sendBtn.bindToKeyboard()
        
        emailLbl.text = Firebase.Auth.auth().currentUser?.email
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        guard let message = messageTextView.text, messageTextView.text != "" else {return}
        sendBtn.isEnabled = false
        isSendingMessage = true
        FirebaseStore.inst.sendNewFeed(withMessage: message, uid: Firebase.Auth.auth().currentUser!.uid, groupId: nil) { (isComplete) in
            if isComplete{
                dismiss(animated: true, completion: nil)
            }else{
                print("Error while sending new feed")
            }
            isSendingMessage = false
            sendBtn.isEnabled = true
        }
    }
}

extension NewFeedVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" && !isSendingMessage{
            sendBtn.isEnabled = true
        }else{
            sendBtn.isEnabled = false
        }
    }
}
