//
//  MemeCollectionVC.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 20/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeCollectionVC: UIViewController {

    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK:- Properties
    var selectedMeme: Meme!
    let segueIdentifier = "gotoMemeDetails"
    let cellIdentifier = "memeCollectionCell"
    
    
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidLoad()
        collectionView?.reloadData()
    }
    
    
    //MARK:- Memes List
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    
    //MARK:- setupCollection
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "MemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    
    //MARK:- Prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let memeDetailsVC = segue.destination as! MemeDetailsVC
            memeDetailsVC.meme = selectedMeme
        }
    }
}





//MARK:- CollectionView DataSource & Delegate
extension MemeCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MemeCollectionViewCell
        let item = memes[indexPath.row]
        cell.configureCell(image: item.memedImage, topLabel: item.topText, bottomLabel: item.bottomText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat =  3
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 5
        let cellSpacing: CGFloat = 5
        
    
        return CGSize(width: ((width / numberOfColumns) - (xInsets + cellSpacing)), height: (width / numberOfColumns) - (xInsets + cellSpacing))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMeme = memes[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
}
