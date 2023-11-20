//
//  BasketScreen.swift
//  ShoesShop
//
//  Created by Babochiev on 17.10.2023.
//

import SwiftUI
import MyUISystem

struct BasketScreen: View {
    
    @StateObject var basketViewModel: BasketViewModel
    
    var body: some View {
        NavStack(transition: .custom(.moveAndFade)) {
            BasketViewScreen()
        }
    }
}
