//
//  FirstViewController.swift
//  Firebase Instagram Clone
//
//  Created by Florian Jud on 31.03.17.
//  Copyright © 2017 Florian Jud. All rights reserved.
//

import UIKit

class feedVC: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Define the numbers or rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //Get the content for the tableView rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        
        return cell
    }
    
    
     //Logout function and go back to signup VC
    @IBAction func logoutButtonClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "usersigned")
        UserDefaults.standard.synchronize()
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signUp
        delegate.rememberLogin()
    }

}

