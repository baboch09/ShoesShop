//
//  ShoesListViewModel.swift
//  ShoesShop
//
//  Created by Babochiev on 12.10.2023.
//

import Foundation


final class ShoesListViewModel: ObservableObject {
    
    @Published var isFaveShows = false
    
    @Published var tabBarSection = 0
    @Published var isShowMyShoes = false
    
    @Published var isSheetShowed = false
    
    @Published private(set) var brands = [
        Brand(name: "Nike", isFav: false),
        Brand(name: "Adidas", isFav: false),
        Brand(name: "Puma", isFav: true),
    ]
    
    @Published var sizes: [Int] = [39, 40, 41, 42, 43, 44, 45, 46, 47]
    
    @Published private(set) var myShoes = [
        Shoes1(name: "Jordan", size: 42),
        Shoes1(name: "Ozilia", size: 42),
    ]
    
    func switchTab(to: TabType) {
        tabBarSection = to.tabIndex
    }
}

enum TabType: Int {
    case main           = 0
    case basket         = 1
    case fav            = 2
    case profile        = 3
    
    var tabIndex: Int {
        return self.rawValue
    }
}

struct Brand {
    let name: String
    let isFav: Bool
}

struct Shoes1 {
    let name: String
    let size: Int
}

extension Shoes1: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

extension Brand: Identifiable {
    var id: String {
        UUID().uuidString
    }
}
