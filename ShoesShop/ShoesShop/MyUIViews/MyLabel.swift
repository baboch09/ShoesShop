//
//  MyLabel.swift
//  ShoesShop
//
//  Created by  Эдик on 13.03.2023.
//

import Foundation
import SwiftUI

struct MyLabel: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UILabel {
        UILabel()
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}
