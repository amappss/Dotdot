//
//  LoginEmailVC.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit
import Firebase
class LoginEmailVC: UIViewController {

    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text else {return}
        Auth.inst.signinUser(withEmail: email, andPassword: password) { (res, error) in
            if res {
                self.dismiss(animated: true, completion: nil)
            }else {
                debugPrint(error?.localizedDescription as Any)
            }
            
            Auth.inst.signupUser(withEmail: email, andPassword: password) { (res, error) in
                if res {
                    self.dismiss(animated: true, completion: nil)
                    print("Created user successfully")
                }else{
                    debugPrint(error?.localizedDescription as Any)
                }
            }
        }
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
