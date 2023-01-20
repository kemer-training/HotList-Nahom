//
//  DetailViewController.swift
//  HotList
//
//  Created by NAHØM on 20/01/2023.
//

import UIKit

class DetailViewController: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    var hotListItem: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let hotListItem = hotListItem else { return }
        
        imageView.loadImage(url: hotListItem.artworkUrl100!)
        nameLabel.text = hotListItem.name
        artistNameLabel.text = hotListItem.artistName
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
}
