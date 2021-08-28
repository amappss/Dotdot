//
//  MeVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit
import Firebase
class MeVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailLbl.text = Firebase.Auth.auth().currentUser?.email
    }
    

    @IBAction func logoutPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout?", message: "Do you really want to log out?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (action) in
            Auth.inst.logout()
            let loginTypeVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginTypeVC
            loginTypeVC.modalPresentationStyle = .fullScreen
            self.present(loginTypeVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in  }
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
