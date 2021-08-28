//
//  GroupsVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit
import Firebase
class GroupsVC: UIViewController, GroupsDelegate {

    @IBOutlet weak var groupsTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTbl.delegate = self
        groupsTbl.dataSource = self
        
        FirebaseStore.inst.groupsDelegate = self
        FirebaseStore.inst.loadGroups(forUserId: Firebase.Auth.auth().currentUser!.uid)
    }
    
    @IBAction func newGroupPressed(_ sender: Any) {
    }
    
    func groupsChanged() {
        groupsTbl.reloadData()
    }

}

extension GroupsVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FirebaseStore.inst.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell {
            cell.setupCell(group: FirebaseStore.inst.groups[indexPath.row])
            return cell
        } else {
          return GroupCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initGroupFeedVC(group: FirebaseStore.inst.groups[indexPath.row])
        groupFeedVC.modalPresentationStyle = .fullScreen
        showDetail(groupFeedVC)
    }
    
}
