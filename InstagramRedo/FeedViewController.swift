//
//  FeedViewController.swift
//  InstagramRedo
//
//  Created by Aashima Garg on 3/1/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var postObjects: [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        //setting table view to 20 images
        let query = PFQuery(className: "AashPost")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (response: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.postObjects = response
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //set table view to lots of cells!
        if let postObjects = postObjects {
            return postObjects.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        let post = postObjects![indexPath.row]
        
        //grabbing image
        let image = post["media"] as! PFFile
        
        //convert from pffile back to uiimage
        image.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
            if let data = data {
                cell.postView.image = UIImage(data: data)
            }
        })
        
        //grabbing caption
        cell.captionLabel.text = post["caption"] as? String
        
        
        return cell
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        
        PFUser.logOut()
        
        //go back to login screen
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("go back to login screen")
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
