//
//  ContentView.swift
//  ShoesShop
//
//  Created by  Эдик on 06.03.2023.
//

import SwiftUI
import ShoesNetwork

struct ContentView: View {
    
    @State var myLabelString: String = "Приложение дополняется..."
    @State var isTapped: Bool = false
    @EnvironmentObject var basketViewModel: BasketViewModel
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    var body: some View {
        TabView(selection: $viewModel.tabBarSection) {
            ShoesScreen()
                .tag(TabType.main.tabIndex)
                .tabItem({
                    Label("Main", systemImage: "house")
                })
            BasketScreen(basketViewModel: basketViewModel)
                .tag(TabType.basket.tabIndex)
                .tabItem({
                    Label("Basket", systemImage: "basket")
                })
                .badge(basketViewModel.selectedShoes.count )
//            VStack {
//                Text("💜")
//                    .font(.system(size: 300))
//                Button {
//                    viewModel.tabBarSection = 3
//                    viewModel.isShowMyShoes = true
//                } label: {
//                    Text("Мои кроссовки")
//                }.buttonStyle(.borderedProminent)
//                MyLabel(text: $myLabelString)
//            }
//            .tag(TabType.fav.tabIndex)
//            .tabItem({
//                Label("Главная", systemImage: "heart")
//            })
            ProfileScreen()
                .tag(TabType.profile.tabIndex)
                .tabItem({
                    Label("Профиль", systemImage: "person")
                })
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}
