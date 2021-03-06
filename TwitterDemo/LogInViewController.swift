//
//  LogInViewController.swift
//  TwitterDemo
//
//  Created by The Boss on 2/28/16.
//  Copyright © 2016 The Boss. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        let client = TwitterClient.sharedInstance
        
        client.login({ () -> () in
            print("I've logged in")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            }) {(error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
