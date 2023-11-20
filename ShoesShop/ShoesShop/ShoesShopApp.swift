//
//  ShoesShopApp.swift
//  ShoesShop
//
//  Created by  Эдик on 06.03.2023.
//

import SwiftUI
import ShoesNetwork

@main
struct ShoesShopApp: App {
    
    init() {
        UITabBarItem.appearance().badgeColor = UIColor.purple
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ShoesListViewModel())
                .environmentObject(BasketViewModel())
        }
    }
}
