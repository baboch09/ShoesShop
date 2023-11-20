//
//  MySteakersScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 13.03.2023.
//

import SwiftUI

struct MySteakersScreen: View {
    
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    var body: some View {
        List {
            ShoesSingleScreen(title: "123")
            ShoesSingleScreen(title: "123")
        }.navigationTitle("Мои кроссовки")
    }
}

struct MySteakersScreen_Previews: PreviewProvider {
    static var previews: some View {
        MySteakersScreen()
            .environmentObject(ShoesListViewModel())
    }
}
