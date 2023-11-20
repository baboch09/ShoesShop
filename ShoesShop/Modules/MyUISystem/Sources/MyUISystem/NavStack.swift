//
//  NavStack.swift
//
//
//  Created by Babochiev on 16.10.2023.
//

import SwiftUI

final public class NavStackViewModel: ObservableObject {
    
    @Published fileprivate var current: Screen?
    
    private var screenStack: ScreenStack = .init() {
        didSet {
            current = screenStack.top()
        }
    }
    
    var easing: Animation = .easeInOut(duration: 0.5)
    var navigationType: NavType = .push
    
    func push<S: View>(_ screen: S) {
        let screen: Screen = .init(id: UUID().uuidString,
                                   nextScreen: AnyView(screen))
        navigationType = .push
        withAnimation(easing) {
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        navigationType = .pop
        withAnimation(easing) {
            switch to {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
    
}

public struct NavStack<Content>: View where Content: View {
    
    @StateObject var viewModel: NavStackViewModel = .init()
    
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    public var easing: Animation {
        get {
            viewModel.easing
        }
        set {
            viewModel.easing = newValue
        }
    }
    
    public init(transition: NavTransition,
                easing: Animation = .easeInOut(duration: 0.33),
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        switch transition {
        case .custom(let t):
            self.transition = (t, t)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    
    public var body: some View {
        let isRoot = viewModel.current == nil
        
        return ZStack(alignment: .topLeading) {
            if isRoot {
                content
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.current!.nextScreen
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
                NavStackPop(destination: .previous) {
                    Text("Back")
                        .padding()
                }
                .environmentObject(viewModel)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                
            }
        }
    }
}

public struct NavStackPush<Content, Destination>: View where Content: View, Destination: View {
    
    @EnvironmentObject var viewModel: NavStackViewModel
    
    private let content: Content
    private let destination: Destination
    
    public init(destination: Destination, @ViewBuilder content: @escaping ()->Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            push()
        }
    }
    
    private func push() {
        viewModel.push(destination)
    }
    
}

public struct NavStackPop<Content>: View where Content: View {
    
    @EnvironmentObject var viewModel: NavStackViewModel
    
    private let content: Content
    private let destination: PopDestination
    
    public init(destination: PopDestination, @ViewBuilder content: @escaping ()->Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
    
}



//MARK: - Enum

public enum PopDestination {
    case previous
    case root
}

public enum NavTransition {
    case none
    case custom(AnyTransition)
}

enum NavType {
    case push
    case pop
    case byId
}

//MARK: - Base Logic

private struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

private struct ScreenStack {
    
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
    
}





//
//#Preview {
//    NavStack()
//}
