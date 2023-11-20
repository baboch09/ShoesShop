//
//  BasketViewScreen.swift
//  ShoesShop
//
//  Created by Babochiev on 17.10.2023.
//

import SwiftUI
import ShoesNetwork
import MyUISystem

struct BasketViewScreen: View {
    
    @EnvironmentObject var basketViewModel: BasketViewModel
    @EnvironmentObject var viewModel: ShoesListViewModel
    
    @State private var totalAmount: Double = 0.0
    @State private var sneakers: [Shoes] = []
    
    
    var body: some View {
        VStack {
            Text("Basket")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding()
            if basketViewModel.selectedShoes.isEmpty {
                EmptyBasketScreen()
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Your order")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Spacer()
                        Button {
                            basketViewModel.selectedShoes = []
                        } label: {
                            Image(systemName: "trash")
                                .font(.system(size: 25))
                        }
                    }
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(basketViewModel.selectedShoes) { sneaker in
                                BasketSneakerCell(totalAmount: $totalAmount, sneaker: sneaker)
                                if sneaker.id != basketViewModel.selectedShoes.last?.id {
                                    Divider()
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Количество кроссовок: \(basketViewModel.selectedShoes.count)")
                            .font(.system(size: 15, design: .serif))
                            .foregroundStyle(.purple)
                        Text("Итоговая сумма: $\(Int(totalAmount))")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .onAppear {
                                self.totalAmount = 0
                                basketViewModel.selectedShoes.forEach { shoes in
                                    if let price = shoes.price {
                                        self.totalAmount += price
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal, 15)
                Button(action: {
                    viewModel.tabBarSection = 3
                    basketViewModel.buyShoes()
                    viewModel.isShowMyShoes = true
                }) {
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding()
            }
            Spacer()
        }
        .onAppear {
            basketViewModel.downloadSelectedShoes()
        }
    }
}



final class BasketViewModel: ObservableObject {
    
    @Published var selectedShoes: [Shoes] = .init()
    @Published var purchasedShoes: [Shoes] = .init()
    
    func downloadSelectedShoes() {
//        ShoesAPI.getSelectedShoes() { data, error in
//            if error == nil, let shoes = data {
//                self.selectedShoes = shoes
//            }
//        }
    }
    
    func buyShoes() {
        purchasedShoes.append(contentsOf: selectedShoes)
        selectedShoes.removeAll()
    }
    
    func addShoesToBasket(shoes: Shoes) {
        selectedShoes.append(shoes)
    }
    
    func removeShoes(shoes: Shoes) {
        selectedShoes = selectedShoes.filter { $0.id != shoes.id }
    }
    
}


struct BasketSneakerCell: View {
    
    @Binding var totalAmount: Double
    @EnvironmentObject var basketViewModel: BasketViewModel
    
    let sneaker: Shoes
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: sneaker.img ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150, maxHeight: 150)
                case .failure:
                    Image(systemName: "shoe")
                }
            }
            
            VStack(alignment: .leading) {
                Text(sneaker.name ?? "aloha")
                    .font(.headline)
                Spacer().frame(height: 10)
                Text("Size: \(sneaker.size ?? 99)")
                    .font(.subheadline)
                Text("Price: $\(Int(sneaker.price ?? 0))")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                
            }
            .padding(.leading, 10)
            Spacer()
            Button(action: {
                totalAmount -= Double(sneaker.price ?? 0)
                basketViewModel.removeShoes(shoes: sneaker)
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 25))
            }
            .foregroundColor(.purple)
        }
        .padding(.vertical, 8)
    }
}
