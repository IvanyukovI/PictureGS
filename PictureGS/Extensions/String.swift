//
//  String.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 26.11.2022.
//

import Foundation
extension String {
    
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
