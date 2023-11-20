//
//  BrandCell.swift
//  ShoesShop
//
//  Created by Babochiev on 27.10.2023.
//

import SwiftUI
import ShoesNetwork

struct BrandCell: View {
    @State var brand: String
    @StateObject var shoesViewModel = ShoesViewModel()
    
    var body: some View {
        Button {
            shoesViewModel.visibleShoes = shoesViewModel.allShoes.compactMap { shoes in
                if shoes.brand == brand {
                    return shoes
                }
                return nil
            }
        } label: {
            Text(brand)
                .padding(10)
                .foregroundColor(.black)
                .font(.system(size: 14))
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
