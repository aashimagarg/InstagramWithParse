//
//  PostCell.swift
//  InstagramRedo
//
//  Created by Aashima Garg on 3/6/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
