//
//  ImageModel.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 26.11.2022.
//

import Foundation

struct SearchImageResponse: Codable {
    
    let images_results: [Image]
}

struct Image: Codable {
    
    let position: Int
    let thumbnail: String?
    let source: String?
    let title: String?
    let link: String?
    let original: String?
    let is_product: Bool
       
}
