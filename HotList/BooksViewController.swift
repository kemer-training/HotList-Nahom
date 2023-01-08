//
//  BooksViewController.swift
//  HotList
//
//  Created by NAHØM on 05/01/2023.
//

import UIKit

class BooksViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "HotListCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HotListCell")
    }
    
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotListCell", for: indexPath) as! HotListTableViewCell

        cell.nameLabel.text = "Adventures of Sherlock Holmes"
        cell.artistNameLabel.text = "Arthur Conan Doyle"
        return cell
    }
}
