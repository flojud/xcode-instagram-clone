//
//  FirstViewController.swift
//  Firebase Instagram Clone
//
//  Created by Florian Jud on 31.03.17.
//  Copyright © 2017 Florian Jud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SDWebImage

class feedVC: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromServer()
    }
    
    //Fetch data from Firebaseserver
    var userNameArray = [String]()
    var postTextArray = [String]()
    var postImageURLArray = [String]()
    
    func getDataFromServer(){
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            
            //Parse JSON Response from Database
            let values = snapshot.value! as! NSDictionary
            let posts = values["posts"] as! NSDictionary
            let postIDs = posts.allKeys
            
            for id in postIDs {
                let singlePost = posts[id] as! NSDictionary
                self.userNameArray.append(singlePost["postedby"] as! String)
                self.postTextArray.append(singlePost["posttext"] as! String)
                self.postImageURLArray.append(singlePost["image"] as! String)
            }
            
            self.tableView.reloadData()
            
        })
    }
    
    //Number of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    
    //Assign the labels and images with the fetched content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.postText.text = postTextArray[indexPath.row]
        cell.userName.text = userNameArray[indexPath.row]
        cell.postImage.sd_setImage(with: URL(string: self.postImageURLArray[indexPath.row]))
      
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

