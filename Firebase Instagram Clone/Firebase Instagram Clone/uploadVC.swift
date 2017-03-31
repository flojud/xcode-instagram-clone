//
//  SecondViewController.swift
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

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
    
    //create a unique id for the image
    var uuid = NSUUID().uuidString
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Initialize the gesture recognizer for the image
        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.selectImage))
        postImage.addGestureRecognizer(gestureRecognizer)
    }

    //What will happen when you click on the image
    func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        postImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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

    //Save the picture and the post into Firebase
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        //First: Upload image firebase
        let mediaFolder = FIRStorage.storage().reference().child("media")
        if let data = UIImageJPEGRepresentation(postImage.image!, 0.5){
                mediaFolder.child("\(uuid).jpg").put(data, metadata: nil, completion: { (metadata, error) in
                    
                    //If an connection error occources give an alert
                    if error != nil{
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        
                        //Else save the post and some more stuff into the database
                        let imageUrl = metadata?.downloadURL()?.absoluteString
                        let post = ["image" : imageUrl!, "postedby" : FIRAuth.auth()!.currentUser!.email!, "uuid" : self.uuid, "posttext" : self.postText.text] as [String : Any]
                        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("posts").childByAutoId().setValue(post)
                        
                        //Reset the items in VC and switch the tab bar VC
                        self.postImage.image = UIImage(named: "tapme.png")
                        self.postText.text = ""
                        self.uploadButton.isEnabled = false
                        self.uploadButton.isEnabled = true
                        self.tabBarController?.selectedIndex = 0
                        
                    }
                })
            
            
        }
        
        
    }
}

