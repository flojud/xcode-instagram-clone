//
//  feedCell.swift
//  Firebase Instagram Clone
//
//  Created by Florian Jud on 31.03.17.
//  Copyright © 2017 Florian Jud. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
