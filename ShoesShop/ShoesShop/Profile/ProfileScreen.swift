//
//  ProfileScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 06.03.2023.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding()
            HStack {
                VStack {
                    Text("Edik Babochiev")
                    Text("24 age")
                }
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 150))
            }
            Text("Мои кроссовки")
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                .onTapGesture {
                    viewModel.isSheetShowed.toggle()
                }
                .onAppear {
                    if viewModel.isShowMyShoes {
                        viewModel.isSheetShowed.toggle()
                    }
                }
                .sheet(isPresented: $viewModel.isSheetShowed) {
                    ProfileSneakerScreen()
                        .onDisappear {
                            viewModel.isShowMyShoes = false
                        }
                }
            Spacer()
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
