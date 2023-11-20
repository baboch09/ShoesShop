//
//  AnyTransition.swift
//
//
//  Created by Babochiev on 17.10.2023.
//

import SwiftUI

public extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.opacity.combined(with: .slide)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
