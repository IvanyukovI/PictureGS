//
//  ViewController.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 26.11.2022.
//

import UIKit
import SDWebImage

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var imagesModel: [Image] = [Image]()
    var position: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: imagesModel[position].thumbnail ?? "")
        statusButton()
        navigationItem.largeTitleDisplayMode = .never

    }
    
    @IBAction func buttonLeftTap(_ sender: Any) {
        
        position -= 1
        configure(with: imagesModel[position].thumbnail ?? "")
        statusButton()
        print("left")
    }
    
    @IBAction func buttonRightTap(_ sender: Any) {
        
        position += 1
        configure(with: imagesModel[position].thumbnail ?? "")
        statusButton()
        print("right")
    }
    
    func configure(with model: String){
        
        guard let url = URL(string: model) else {return}
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func goToOriginalSIte(_ sender: Any) {

        let detailsWVC = DetailsWVC()
        detailsWVC.urlSite = imagesModel[position].link ?? ""
        detailsWVC.modalPresentationStyle = .fullScreen
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        show(detailsWVC, sender: nil)
    }
    
    func statusButton () {
        
        if position == 0 {
            leftButton.isEnabled = false
            rightButton.isEnabled = true
        } else if position > 0, position <= imagesModel.count {
            leftButton.isEnabled = true
            rightButton.isEnabled = true
        } else {
            leftButton.isEnabled = true
            rightButton.isEnabled = false
        }
        
    }
    
    
}
