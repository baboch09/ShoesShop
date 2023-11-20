//
//  ProductsViewModel.swift
//  ShoesShop
//
//  Created by Babochiev on 12.10.2023.
//

import Foundation
import ShoesNetwork

// Модель с настоящей апишкой но там мало нужных данных, использовать при необходимости
class ProductsViewModel: ObservableObject {
    
    @Published var allProducts: [SingleProduct] = .init()
    
    func downloadAllProducts() {
        ProductsAPI.getAllProducts() { data, error in
            if error == nil, let data = data {
                self.allProducts.append(contentsOf: data.products ?? [])
                print(123)
            }
        }
    }
    
    func downloadAllShoes() {
        ProductsAPI.getShoes() { data, error in
            if error == nil, let data = data {
                self.allProducts = data.products ?? []
                print(123)
            }
        }
    }
}
