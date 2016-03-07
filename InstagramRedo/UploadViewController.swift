//
//  UploadViewController.swift
//  InstagramRedo
//
//  Created by Aashima Garg on 3/6/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionField: UITextField!
    var postImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChoose(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    @IBAction func onPost(sender: AnyObject) {
        
        Post.postUserImage(postImage, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if(success){
                print("image posted successfully")
            }
            if(error != nil){
                print(error?.localizedDescription)
            }
        }
        captionField.text = ""
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("go back to feed screen")
        }
    
    }

    @IBAction func onCancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("go back to feed screen")
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            // Do something with the images (based on your use case)
            postImage = originalImage
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
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
