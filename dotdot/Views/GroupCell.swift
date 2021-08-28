//
//  GroupCell.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/7/21.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var membersLbl:UILabel!

    func setupCell(group:Group){
        titleLbl.text = group.title
        descriptionLbl.text = group.description
        membersLbl.text = "\(group.members.count) members"
    }

}
