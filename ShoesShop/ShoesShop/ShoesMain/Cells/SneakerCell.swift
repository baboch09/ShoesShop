//
//  SneakerCell.swift
//  ShoesShop
//
//  Created by Babochiev on 27.10.2023.
//

import SwiftUI
import ShoesNetwork


struct SneakerCell: View {
    let sneaker: Shoes
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: sneaker.img!)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 8)
                        .opacity(isAnimating ? 0.5 : 1)
                case .failure:
                    Image(systemName: "shoe")
                }
            }
            Text(sneaker.name ?? "asd")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 0)
        .padding(.vertical, 4)
        
    }
}
