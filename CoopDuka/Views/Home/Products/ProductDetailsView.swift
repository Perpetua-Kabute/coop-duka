//
//  ProductDetailsView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
//    let allProducts: [Product]
    @ObservedObject var viewModel: ProductsViewModel

    @State private var isDescriptionExpanded = false
    @State private var showCartBanner = false
    @Environment(\.dismiss) private var dismiss

    private let relatedColumns = [GridItem(.flexible()), GridItem(.flexible())]

    private var imageURL: URL? {
        URL(string: "https://picsum.photos/seed/\(product.id)/800/600")
    }

    private var priceAmount: String {
        let amount = (product.id % 20 + 1) * 100
        if amount >= 1000 {
            return String(format: "%d,%03d.00", amount / 1000, amount % 1000)
        }
        return String(format: "%d.00", amount)
    }

    private let categories = ["Apparel", "Accessories", "Bags", "Footwear", "Stationery"]
    private var category: String { categories[product.id % categories.count] }

    private var relatedPosts: [Product] { viewModel.filteredProducts.filter { $0.id != product.id }.prefix(6).map { $0 } }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Product Image
                    AsyncImage(url: imageURL) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Color.gray.opacity(0.15)
                                .overlay(Image(systemName: "photo").foregroundColor(.gray))
                        } else {
                            Color.gray.opacity(0.1).overlay(ProgressView())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(8)
                    .padding(16)

                    // Product Info
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.title.capitalized)
                            .font(.system(size: 20, weight: .bold))

                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("\(priceAmount) KES")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("DarkGreenText"))

                            Text("VAT Inclusive")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }

                        Text(category)
                            .font(.system(size: 15))
                            .foregroundColor(.primary)

                        ExpandableText(text: product.body, isExpanded: $isDescriptionExpanded)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    // Add To Cart
                    Button(action: {
                        showCartBanner = true //remove
                        viewModel.addProductToCart(product: product)
                        dismiss()
                    }) {
                        Text("Add To Cart")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("CoopPrimaryGreen"))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 28)

                    // Best Selling
                    if !relatedPosts.isEmpty {
                        Text("Best Selling")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)

                        LazyVGrid(columns: relatedColumns, spacing: 16) {
                            ForEach(relatedPosts) { related in
                                ProductCard(product: related)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }
                }
            }
            .background(Color("BackgroundColor"))

            // Cart success toast..//move to home view
            if showCartBanner {
                CartSuccessBanner { showCartBanner = false }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showCartBanner)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(product.title.capitalized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    // MARK: - Expandable Text

    private struct ExpandableText: View {
        let text: String
        @Binding var isExpanded: Bool

        private var shortText: String {
            guard text.count > 120 else { return text }
            return String(text.prefix(120))
        }

        private var needsTruncation: Bool { text.count > 120 }

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(isExpanded ? text : shortText)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .lineSpacing(4)

                if needsTruncation {
                    Button(action: { isExpanded.toggle() }) {
                        Text(isExpanded ? "...see less" : "...see more")
                            .font(.system(size: 15))
                            .underline()
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}



