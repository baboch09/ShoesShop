//
//  ProfileSneakerScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 13.03.2023.
//

import SwiftUI

struct ProfileSneakerScreen: View {
    
    @EnvironmentObject var viewModel: ShoesListViewModel
    @EnvironmentObject var basketVM: BasketViewModel
    
    var body: some View {
        VStack {
            Text("Мои кроссовки")
                .font(.system(size: 30))
                .padding(.top, 25)
            Spacer()
            if basketVM.purchasedShoes.isEmpty {
                VStack {
                    Text("Пока пусто")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 10)
                    Text("Купи кроссовки, все так говорят а ты купи кроссовки!")
                    Spacer()
                }.padding()
            } else {
                List {
                    ForEach(basketVM.purchasedShoes) { sneakers in
                        HStack {
                            Text(sneakers.name ?? "")
                            Spacer()
                            Image(systemName: "heart.circle")
                                .foregroundStyle(.purple)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileSneakerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSneakerScreen()
    }
}
