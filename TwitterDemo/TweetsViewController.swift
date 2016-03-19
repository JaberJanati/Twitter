//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by The Boss on 3/3/16.
//  Copyright © 2016 The Boss. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        
        
        TwitterClient.sharedInstance.homeTimeLine({(tweets: [Tweet]) ->  () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            for tweet in tweets {
                print(tweet.text)
            }}, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
            })
        let currentUser = User.currentUser
        
        print("\n\n\nHello\n\n")
        
        profileImage.setImageWithURL(currentUser!.profileUrl!)
        followingLabel.text = String(currentUser!.followingCount!)
        followersLabel.text = String(currentUser!.followersCount!)
       tweetsLabel.text = String(currentUser!.listedCount!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets == nil {
            return 0
        }
        else {
            print("The count is \(tweets.count)")
            return tweets.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let userData = tweets[indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! TweetsDetailViewController
        detailViewController.userData = userData
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
