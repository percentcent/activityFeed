//
//  ActivityFeedTableViewCell.swift
//  activityFeed
//
//  Created by peishan lee on 17/10/18.
//  Copyright © 2018 The University of Melbourne. All rights reserved.
//

import UIKit

class ActivityFeedTableViewCell: UITableViewCell {
    //MARK: properties
    
    @IBOutlet weak var activityFeedDetail: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
