//
//  ActivityFeedViewController.swift
//  activityFeed
//
//  Created by peishan lee on 16/10/18.
//  Copyright © 2018 The University of Melbourne. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import AlamofireImage

class ActivityFeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //MARK properties
    @IBOutlet weak var activityFeedTableView: UITableView!
    
    @IBOutlet weak var youButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    var ActivityFeeds = UpdateActivityFeed()
    var followOrYouStatus : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityFeedTableView.delegate = self
        activityFeedTableView.dataSource = self
        //load sample data
        //loadSampleData()
        initializeData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ActivityFeeds.ActivityFeedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ActivityFeedTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActivityFeedTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of ActivityFeedTableViewCell.")
        }
        
        let feed = ActivityFeeds.ActivityFeedsList[indexPath.row]
        cell.activityFeedDetail.text = feed.detail
        
        /*
        let userUrl = feed.userImageUrl!
        Alamofire.request(userUrl).responseImage(completionHandler: { (response) in
            print(response)
            if let image = response.result.value {
                let circularImage = image.af_imageRoundedIntoCircle()
                DispatchQueue.main.async {
                    cell.userImage.image = circularImage
                }
            }
        })
        */
        
        //let processor = RoundCornerImageProcessor(cornerRadius: 40)
        let userUrl = URL(string: feed.userImageUrl!)
        cell.userImage.kf.setImage(with: userUrl)
        
        if feed.likeOrStartFollwing{
            cell.postImage.isHidden = false
            let postUrl = URL(string: feed.postImageUrl!)
            cell.postImage.kf.setImage(with: postUrl)
        }
        else{
            cell.postImage.isHidden = true
        }
        //print(feed.detail)
        return cell
    }
    
    //MARK : button func
    

    @IBAction func followingUpdate(_ sender: UIButton) {
        self.activityFeedTableView?.reloadData()
        ActivityFeeds.getActivityFeed(YouOrFollowing: false)
        followOrYouStatus = true
        updateButtonStyle()
        
    }
    
    @IBAction func youUpdate(_ sender: UIButton) {
        self.activityFeedTableView?.reloadData()
        ActivityFeeds.getActivityFeed(YouOrFollowing: true)
        followOrYouStatus = false
        updateButtonStyle()
        
    }
    
    func initializeData(){
        self.activityFeedTableView?.reloadData()
        ActivityFeeds.getActivityFeed(YouOrFollowing: false)
        followOrYouStatus = true
        updateButtonStyle()
        
    }
    
    //MARK : private func
    private func updateButtonStyle(){
        if followOrYouStatus{
            highlightButton(Button: self.followingButton)
            initializeButton(Button: self.youButton)
        }
        else{
            highlightButton(Button: self.youButton)
            initializeButton(Button: self.followingButton)
        }
    }
    private func highlightButton(Button : UIButton){
        Button.backgroundColor = UIColor.gray
        Button.setTitleColor(UIColor.black, for: .normal)
        //need to transition to initial state when suggested users show again?
    }
    
    private func initializeButton(Button : UIButton){
        Button.backgroundColor = UIColor.white
        Button.setTitleColor(UIColor.darkGray, for: .normal)
        
    }
    
    private func loadSampleData()
    {
        ActivityFeeds.ActivityFeedsList = []
        guard let feed1 = ActivityFeed(userImageUrl: "https://httpbin.org/image/png", likeOrStartFollwing: true, userName: "test", nextUserName: "test2", postImageUrl: "https://httpbin.org/image/png", activityTime: "1 day", youOrFollowing: false) else {
            fatalError("Unable to instantiate feed1")
        }
        feed1.generateDetail()
        
        ActivityFeeds.ActivityFeedsList += [feed1]
    
    }
    
}

