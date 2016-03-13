//
//  TweetsCell.swift
//  TwitterDemo
//
//  Created by The Boss on 3/5/16.
//  Copyright © 2016 The Boss. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweet: UILabel!
    @IBOutlet weak var likeCount: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user.name as? String
            tweetText.text =  tweet.text as? String
            //timeStamp.text = "timestam"
            profileImage.setImageWithURL(tweet.user.profileUrl!)
            retweet.text = String(tweet.retweetCount)
            likeCount.text = String(tweet.favoritesCount)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
