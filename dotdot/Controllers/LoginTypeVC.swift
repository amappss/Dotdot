//
//  LoginTypeVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit
import Firebase
class LoginTypeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Firebase.Auth.auth().currentUser != nil{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
    }
    
    @IBAction func gmailLoginPressed(_ sender: Any) {
    }
    @IBAction func loginEmailPressed(_ sender: Any) {
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
