//
//  ShoesScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 06.03.2023.
//

import SwiftUI
import MyUISystem



struct ShoesScreen: View {
    
    var body: some View {
        NavStack(transition: .custom(.moveAndFade)) {
            ShoesListScreen()
        }
    }
}



struct ShoesScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShoesScreen()
    }
}
