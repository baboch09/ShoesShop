//
//  ShoesButton.swift
//
//
//  Created by Babochiev on 16.10.2023.
//

import SwiftUI

public struct ShoesButton<Content>: View where Content: View {
    
    private let bgColor: Color
    private let action: () -> Void
    private let content: () -> Content
    
    @State var bgOpacity: Double = 1
    
    public init(bgColor: Color, action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.bgColor = bgColor
        self.action = action
        self.content = content
    }

    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(bgColor)
                .opacity(bgOpacity)
            HStack {
                content()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .fixedSize(horizontal: true, vertical: true)
            .gesture(
                DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                    .onChanged { _ in
                        withAnimation {
                            bgOpacity = 0.5
                        }
                    }
                    .onEnded { _ in
                        bgOpacity = 1
                        action()
                    }
            )
        }
    }
}


struct ShoesButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ShoesButton(bgColor: .red) {} content: {
                Text("qe")
            }
        }
    }
}
