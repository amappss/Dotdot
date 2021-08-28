//
//  FeedVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseStore.inst.feedsDelegate = self
        feedTbl.delegate = self
        feedTbl.dataSource = self
        FirebaseStore.inst.loadDBFeeds()
    }

    @IBAction func newFeedPressed(_ sender: Any) {
    }
    


}

extension FeedVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseStore.inst.feeds.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell{
            let message = FirebaseStore.inst.feeds[indexPath.row]
            cell.setupView(email: message.senderEmail, message: message.context)
            return cell
        }else{
            return FeedCell()
        }
    }
}

extension FeedVC : FeedsDelegate {
    func feedsChanged() {
        feedTbl.reloadData()
    }
}
