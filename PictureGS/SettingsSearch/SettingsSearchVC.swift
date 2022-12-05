//
//  SettingsSearchVC.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 29.11.2022.
//

import UIKit

class SettingsSearchVC: UIViewController {
    
    @IBOutlet weak var typeSearchLabel: UILabel!
    @IBOutlet weak var resultSizeLabel: UILabel!
    @IBOutlet weak var rsultCountyLabel: UILabel!
    @IBOutlet weak var resultLenguageLabel: UILabel!
    
    @IBOutlet weak var itemButtonTypeSearch: UIButton!
    @IBOutlet weak var itemButtonSize: UIButton!
    @IBOutlet weak var itemButtonCountry: UIButton!
    @IBOutlet weak var itemButtonLenguage: UIButton!
    
    static let reuseId = "SettingsSearchVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings search"

    }

}
