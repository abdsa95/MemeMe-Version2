//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 20/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
   
    
    func configureCell(image: UIImage, topLabel: String, bottomLabel: String ){
        self.memeImage.image = image
        self.topLabel.text = topLabel
        self.bottomLabel.text = bottomLabel
    }

}
