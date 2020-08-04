//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 20/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var buttomLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    

    
    func configureCell(image: UIImage, topText: String, buttomText: String){
        memeImage.image = image
        topLabel.text = topText
        buttomLabel.text = buttomText
        detailLabel.text = "\(topText).....\(buttomText)"
    }
    
}
