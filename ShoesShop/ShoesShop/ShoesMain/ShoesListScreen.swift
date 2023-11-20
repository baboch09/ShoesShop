//
//  ShoesListScreen.swift
//  ShoesShop
//
//  Created by  Эдик on 11.03.2023.
//

import SwiftUI
import ShoesNetwork
import Combine
import MyUISystem


struct ShoesListScreen: View {
    
    @StateObject var productsViewModel = ProductsViewModel()
    @StateObject var shoesViewModel = ShoesViewModel()
    
    @State var isShowAlert: Bool = false
    
    let brands = ["Adidas","Nike","Puma"]
    
    private var columns: [GridItem] = [ GridItem(), GridItem() ]
    private var brandButtonsIsTaped = [false, false, false, false]
    @State private var selectedButton: Int?

    
    
    var body: some View {
        ZStack {
            VStack {
                brandTitleLabel
                categoryButtons
                shoesList
                Spacer()
            }
            .navigationTitle("Brands-shmends")
            switch isShowAlert {
            case true: modalView
            case false: EmptyView()
            }
        }
    }
    
    
    
    //    func cellProduct(brand: SingleProduct) -> some View{
    //        NavigationLink(destination: ShoesSingleScreen(title: brand.brand ?? "aloha", image: brand.images?.first ?? "")) {
    //            Text(brand.brand ?? "aloha")
    //        }
    //    }
    
    
    
    var shoesList: some View {
        ScrollView {
            LazyVGrid(
                columns: columns
            ) {
                ForEach(shoesViewModel.visibleShoes.isEmpty ? shoesViewModel.allShoes : shoesViewModel.visibleShoes, id: \.id) { shoes in
                    NavStackPush(destination: ShoesSingleScreen(shoes: shoes)) {
                        SneakerCell(sneaker: shoes)
                    }
                }
            }
            .padding(.horizontal, 5)
        }
        .onAppear {
            shoesViewModel.downloadAllProducts()
        }
    }
    
    var brandTitleLabel: some View {
        HStack {
            Button {
                withAnimation(.linear(duration: 1)) {
                    self.isShowAlert = true
                }
                
            } label: {
                Text(shoesViewModel.visibleShoes.first?.brand ?? "All brands")
                    .padding(.horizontal, UIScreen.main.bounds.width/2 - 70)
                    .padding(.vertical, 20)
                    .foregroundColor(.black)
                    .font(.system(size: 24, weight: .bold))
            }
            .frame(minWidth: UIScreen.main.bounds.width)
        }
        .background(Color.backgroundPurple)
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 100)
        
    }
    
    var categoryButtons: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(brands.enumerated()), id: \.offset) { i, brand in
                    brandCategoryButton(for: brand, index: i)
                }
                clearBrandCategoriesButton
            }
        }.padding()
    }
    
    func brandCategoryButton(for brand: String, index: Int) -> some View {
        Button {
            selectedButton = index
            shoesViewModel.visibleShoes = shoesViewModel.allShoes.compactMap { shoes in
                if shoes.brand == brand {
                    return shoes
                }
                return nil
            }
        } label: {
            Text(brand)
                .padding(10)
                .foregroundColor(selectedButton == index ? .white : .black)
                .font(.system(size: 14))
        }
        .background(selectedButton == index ? Color.purple : Color.purple.opacity(0.2))
        .cornerRadius(10)
    }
    
    var clearBrandCategoriesButton: some View {
        Button {
            shoesViewModel.visibleShoes = []
            selectedButton =  nil
        } label: {
            Image("clear_filter")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(10)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    var modalView: some View {
        
        ZStack {
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.01))
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                VStack {
                    Text("You clicked here, well done, THE PHONE WILL EXPLODE IN 5 SECONDS, I’m kidding, IN 10, I understand, I would have clicked too, but it’s just a headline, it indicates which brand was chosen, right now this ( \(shoesViewModel.visibleShoes.first?.brand ?? "All brands") )")
                        .foregroundStyle(.white)
                        .padding()
                        .font(.system(size: 20,weight: .bold))
                    Button {
                        self.isShowAlert = false
                    } label: {
                        Text("Back to shopping")
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .border(Color.white, width: 1.0, cornerRadius: 10)
                    
                }
            }
            .background(Color.clear)
            .frame(maxWidth: 300, maxHeight: 300)
        }
    }
    
}


struct ShoesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShoesListScreen()
            .environmentObject(ShoesListViewModel())
    }
}


