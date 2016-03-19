//
//  TweetsDetailViewController.swift
//  TwitterDemo
//
//  Created by The Boss on 3/19/16.
//  Copyright © 2016 The Boss. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var numOfRetweet: UILabel!
    @IBOutlet weak var numOfFavorites: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    
    var userData: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.setImageWithURL(userData.user.profileUrl!)
        screenNameLabel.text = String(userData.user.screenName!)
        nameLabel.text = String(userData.user.name!)
        tweetLabel.text = String(userData.text)
        numOfRetweet.text = String(userData.retweetCount)
        numOfFavorites.text = String(userData.favoritesCount)

        // Do any aditional setup after loading the view.
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
