//
//  EmptyBasketScreen.swift
//  ShoesShop
//
//  Created by Babochiev on 31.10.2023.
//

import SwiftUI

struct EmptyBasketScreen: View {
    
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "basket")
                .font(.system(size: 200))
                .foregroundStyle(Color.mainPurple)
            Text("Basket is empty")
                .font(.headline)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            Text("Find matching sneakers on the home screen and add them to your basket")
                .font(.subheadline)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                .multilineTextAlignment(.center)
            Button(action: {
                viewModel.switchTab(to: .main)
            }) {
                Text("Go to Main")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(10)
            Spacer()
        }
    }
}
