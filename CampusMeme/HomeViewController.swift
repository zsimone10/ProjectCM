//
//  HomeViewController.swift
//  CampusMeme
//
//  Created by Zen Simone on 7/10/17.
//  Copyright © 2017 zs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class HomeViewController: UIViewController, UICollectionViewDelegate{
    //Declare reference to Database
    var ref: DatabaseReference!
    var campuses = [String]()
    var someInts = [Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.uid as! String)
            let userID = Auth.auth().currentUser?.uid as! String
            configureDatabase(userID: userID)
            //self.printCampuses(Any)
            }
        //else {
            //logout
        //}
        
    }
    
    
    @IBAction func printCampuses(_ sender: Any) {
        print(self.campuses)
    }
    
    func configureDatabase(userID: String) {
        ref = Database.database().reference()
        self.ref.child("Users").child(userID).child("Campuses").observeSingleEvent(of: .value, with: { (snapshot) in
            var this = [String]()
            // Get user value
            //print(snapshot.value)
            let value = snapshot.value as? NSDictionary
            for key in (value?.allKeys)!{
                print("Campus Name: ",  key)
                let foo = value?.object(forKey: key) as! String
                print(foo)
                self.campuses.append(foo)
                //this.append(foo)
                //print(this)
                //self.campuses = this
                
            }
            //let foo = value?.object(forKey: "Stan")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        print(self.campuses)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
