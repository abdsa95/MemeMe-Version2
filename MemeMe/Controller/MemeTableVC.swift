//
//  MemeTableVC.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 20/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeTableVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Proprties
    var selectedMeme: Meme!
    let segueIdentifier = "gotoMemeDetails"
    let cellIdentifier = "memeTableCell"
    
    
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidLoad()
        tableView?.reloadData()
    }
    
    
    //MARK:- Memes List
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    //MARK:- SetupTableView
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "MemeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    //MARK:- Prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let detailVC = segue.destination as! MemeDetailsVC
            detailVC.meme = selectedMeme
        }
    }
}





//MARK:- TableView Delegate & DataSource
extension MemeTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MemeTableViewCell
        let item = memes[indexPath.row]
        cell.configureCell(image: item.memedImage, topText: item.topText, buttomText: item.bottomText)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeme = memes[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
}
