//
//  ShoesSingleScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 11.03.2023.
//

import SwiftUI
import ShoesNetwork
import MyUISystem

struct ShoesSingleScreen: View {

    @EnvironmentObject var basketViewModel: BasketViewModel
    
    @State var shoes: Shoes?
    @State private var quantity: Int = 1
    
    
    var body: some View {
        if let shoes = shoes, let name = shoes.name, let imageURL = shoes.img, let rating = shoes.rating, let description = shoes.desc, let price = shoes.price {
            Color.black.opacity(0)
                .ignoresSafeArea(.all)
                .overlay (
                    VStack {
                        ScrollView {
                            VStack {
                                AsyncImage(url: URL(string: imageURL)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3), contentMode: .fit)
                                    case .failure:
                                        Image(systemName: "shoe")
                                    }
                                }
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Text(name)
                                            .font(.system(size: 24))
                                            .fontWeight(.bold)
                                        Spacer()
                                        HStack {
                                            Text("\(rating)")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.secondary)
                                            Text(Image(systemName: "star.fill"))
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 14))
                                        }
                                    }
                                    Text(description)
                                        .lineLimit(10)
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.secondary)
                                    VStack(alignment: .leading, spacing: 14) {
                                        Text("Size")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        SizeScrollView(shoes: $shoes)
                                    }
                                }
                                .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
                                Spacer()
                            }
                        }
                        .background(Color.backgroundPurple)
                        
                        HStack {
                            VStack(alignment: .center, spacing:4) {
                                Text("Price")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.secondary)
                                Text("$\(Int(price))")
                                    .font(.system(size: 18))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(width: UIScreen.main.bounds.width/2 - 40)
                            AddToBasketButton(shoes: $shoes)
                        }
                        .padding(.bottom, 5)
                    }
                )
        } else {
            EmptyView()
        }
    }
}

struct ShoesSingleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShoesSingleScreen(shoes: Shoes())
    }
}

struct AddToBasketButton: View {
    
    @EnvironmentObject var basketViewModel: BasketViewModel
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    
    @Binding var shoes: Shoes?
    
    @State var selectedSizeIndex: Int = 42
    @State var isAddedToBasket: Bool = false
    @State private var showingSheet = false
    
    
    var body: some View {
        if isAddedToBasket {
            goToBaksetButon
        } else {
            addToBaksetButton
        }
    }
    
    
    var addToBaksetButton: some View {
        Button {
            if let _ = shoes?.size {
                addToBakset(shoes: shoes)
            } else {
                showingSheet.toggle()
            }
        } label: {
            Text("Add to card")
                .padding(20)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
        }
        .sheet(isPresented: $showingSheet) {
            if #available(iOS 16, *) {
                Text("Choose size")
                    .font(.system(size: 18, weight: .semibold))
                Picker("Please choose a size", selection: $selectedSizeIndex) {
                    ForEach(viewModel.sizes, id: \.self) { size in
                        Text("\(size)")
                    }
                }
                .presentationDetents([.medium])
                .pickerStyle(.wheel)
                Button {
                    shoes?.size = Int64(selectedSizeIndex)
                    addToBakset(shoes: shoes)
                    viewModel.switchTab(to: .basket)
                    isAddedToBasket = false
                    showingSheet.toggle()
                } label: {
                    Text("To basket with \(selectedSizeIndex)")
                        .padding(20)
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold))
                }
                .frame(width: UIScreen.main.bounds.width/2 )
                .frame(maxHeight: 60)
                .background(Color.backgroundBlack)
                .cornerRadius(10)
            } else {
                Picker("Please choose a color", selection: $selectedSizeIndex) {
                    ForEach(viewModel.sizes, id: \.self) { _ in
                        Text("123")
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .frame(width: UIScreen.main.bounds.width/2 )
        .frame(maxHeight: 60)
        .background(Color.backgroundBlack)
        .cornerRadius(10)
    }
    
    var goToBaksetButon: some View {
        Button {
            viewModel.switchTab(to: .basket)
            isAddedToBasket = false
        } label: {
            VStack {
                Text("Basket")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                Text("Go to")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .light))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            }
        }
        .frame(width: UIScreen.main.bounds.width/2)
        .frame(maxHeight: 60)
        .background(Color.backgroundBlack)
        .cornerRadius(10)
    }
    
    func addToBakset(shoes: Shoes?) {
        guard let shoes = shoes else { return }
        basketViewModel.addShoesToBasket(shoes: shoes)
        isAddedToBasket = true
    }
}


struct SizeScrollView: View {
    
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    @Binding var shoes: Shoes?
    
    @State var selectedSizeIndex: Int?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(viewModel.sizes.enumerated()), id: \.offset) { index, size in
                    Button {
                        selectedSizeIndex = index
                        shoes?.size = Int64(size)
                    } label: {
                        Text("\(size)")
                            .foregroundColor(selectedSizeIndex == index ? .white : .black)
                            .padding(10)
                            .font(.system(size: 18))
                    }
                    .background(selectedSizeIndex == index ? Color.mainPurple : Color.backgroundSecondPurple)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                }
            }
        }
    }
}


extension Color {
    static var mainPurple: Color {
        return Color.purple.opacity(0.8)
    }
    
    static var backgroundPurple: Color {
        return Color.purple.opacity(0.05)
    }
    
    static var backgroundSecondPurple: Color {
        return Color.purple.opacity(0.2)
    }
    
    static var backgroundBlack: Color {
        return Color.black.opacity(0.9)
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}
