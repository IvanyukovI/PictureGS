//
//  DetailsWVC.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 30.11.2022.
//

import UIKit
import WebKit

class DetailsWVC: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlSite: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlSite) else {return}
        let request = URLRequest(url: url)
        webView.load(request)

        
    }


    @IBAction func toBack(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
