//
//  HomeView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ProductsViewModel()
    @State private var selectedProduct: Product? = nil

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    private var userName: String {
        UserDefaults.standard.string(forKey: "username") ?? "User"
    }

    var body: some View {
        NavigationSplitView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    if viewModel.hasPromotion {
                        PromoBanner(message: viewModel.promotionMessage)
                    }

                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)

                    
                    Text("Best Selling")
                        .font(.custom("Muli", size: 18,))
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredProducts) { product in
                                NavigationLink(value: product) {
                                    ProductCard(product: product)
                                }
                                .buttonStyle(.plain)
                                .simultaneousGesture(TapGesture().onEnded { selectedProduct = product })
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }
                }
            }
            .overlay(alignment: .top) {
                if viewModel.showCartBanner {
                    CartSuccessBanner { viewModel.showCartBanner = false }
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 8)
                }
            }
            .background(Color("BackgroundColor"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 22))
                        .foregroundColor(Color("TextFieldColor"))
                }
                .sharedBackgroundVisibility(.hidden)
                ToolbarItem(placement: .principal) {
                    Text("Hello \(userName)")
                        .font(.custom("Muli", size: 16,))
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: appState.logout) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(Color("TextFieldColor"))
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            }
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product, viewModel: viewModel)
            }
           
        } detail: {
            Text("Select a product to view details")
                .foregroundColor(.secondary)
                .font(.custom("Muli", size: 16,))
                .fontWeight(.semibold)
        }
    }
}

// MARK: - Promo Banner

private struct PromoBanner: View {
    let message: String

    var body: some View {
        HStack {
            Text(message)
                .font(.system(size: 15, weight: .semibold))
                .font(.custom("Muli", size: 15))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(Color("CoopPrimaryGreen"))
    }
}

// MARK: - Search Bar

private struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search products", text: $text)
                .font(.custom("Muli", size: 15))
                .fontWeight(.regular)
            Spacer()
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}









#Preview {
    HomeView()
        .environmentObject(AppState())
}
