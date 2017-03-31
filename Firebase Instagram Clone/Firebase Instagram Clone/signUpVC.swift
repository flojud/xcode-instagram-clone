//
//  signUpVC.swift
//  Firebase Instagram Clone
//
//  Created by Florian Jud on 31.03.17.
//  Copyright © 2017 Florian Jud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpVC: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //Sign in Function
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
         FIRAuth.auth()?.signIn(withEmail: usernameText.text!, password: passwordText.text!, completion: { (user, error) in
            if error != nil{
                
                //show up an alert - error within the sign in firebase auth
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                
            }else{

                //Save user login information to userdefaults ...
                UserDefaults.standard.set(user?.email, forKey: "usersigned")
                UserDefaults.standard.synchronize()
                //... and use the appdelegate rememberlogin function to automaticaly signin
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                delegate.rememberLogin()
                
            }
         })
        }
    }
    
    //Sign up Firebase Auth Function
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            FIRAuth.auth()?.createUser(withEmail: usernameText.text!, password: passwordText.text!, completion: { (user, error) in
                if error != nil{
                    
                    //show up an alert - error within the firebase sign up auth
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    //The sign up was successull
                    let alert = UIAlertController(title: "Success", message: "The sigup was successfull.", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                    //Save user login information to userdefaults ...
                    UserDefaults.standard.set(user?.email, forKey: "usersigned")
                    UserDefaults.standard.synchronize()
                    //... and use the appdelegate rememberlogin function to automaticaly signin
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                    
                }
            })
        }else{
            //show up an alert - no email or password given
            let alert = UIAlertController(title: "Error", message: "Please provide a emailadress and a password!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
    }

}
