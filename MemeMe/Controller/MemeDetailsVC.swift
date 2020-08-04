//
//  MemeDetailsVC.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 22/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeDetailsVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var memeImage: UIImageView!
 
    
    //MARK:- Properties
    var meme: Meme!
    
    
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false 
    }
    
    
    //MARK:- UpdateUI
    func updateUI(){
        memeImage.image = meme.memedImage
    }
}
