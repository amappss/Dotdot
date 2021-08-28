//
//  UserCell.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/6/21.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var emailLbl:UILabel!
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var checkImg:UIImageView!
    
    var selectedRow = false
    func setupCell(email:String,isSelected:Bool){
        emailLbl.text = email
        checkImg.isHidden = !isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            selectedRow = !selectedRow
            checkImg.isHidden = !selectedRow
        }
    }
}
