//
//  MainCVC.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 24.11.2022.
//

import UIKit
import SDWebImage

class MainCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseId = "MainCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: String){
        guard let url = URL(string: model) else {return}
        imageView.sd_setImage(with: url, completed: nil)
    }

}
