//
//  ShoesViewModel.swift
//  ShoesShop
//
//  Created by Babochiev on 12.10.2023.
//

import Foundation
import ShoesNetwork


// Модель с мок апишкой
final class ShoesViewModel: ObservableObject {
    
    @Published var allShoes: [Shoes] = .init()
    @Published var visibleShoes: [Shoes] = .init()
    
    @Published var showAlert = false
    
    func downloadAllProducts() {
        ShoesAPI.getAllShoes() { data, error in
            if error == nil, let data = data {
                self.allShoes = data
            }
        }
    }
}


extension Shoes: Identifiable { }
