//
//  FeedCell.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/5/21.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    func setupView(email:String,message:String){
        emailLbl.text = email
        messageLbl.text = message
    }
}
