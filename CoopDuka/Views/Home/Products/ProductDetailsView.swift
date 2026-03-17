//
//  ProductDetailsView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var viewModel: ProductsViewModel

    @State private var isDescriptionExpanded = false
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
        ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Product Image
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray6))

                        AsyncImage(url: imageURL) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(24)
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .font(.system(size: 48))
                                    .foregroundColor(.gray)
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .padding(16)

                    // Product Info
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.title.capitalized)
                            .font(.custom("Muli", size: 18))
                            .fontWeight(.bold)

                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("\(priceAmount) KES")
                                .font(.custom("Muli", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color("DarkGreenText"))

                            Text("VAT Inclusive")
                                .foregroundColor(.secondary)
                                .font(.custom("Muli", size: 13))
                                .fontWeight(.bold)
                        }

                        Text(category)
                            .font(.custom("Muli", size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        ExpandableText(text: product.body, isExpanded: $isDescriptionExpanded)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    // Add To Cart
                    Button(action: {
                        viewModel.addProductToCart(product: product)
                    }) {
                        Text("Add To Cart")
                            .font(.custom("Muli", size: 16))
                            .fontWeight(.bold)
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
                            .font(.custom("Muli", size: 18))
                            .fontWeight(.bold)
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(product.title.capitalized)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.primary)
                }
            }
            .sharedBackgroundVisibility(.hidden)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .overlay {
            if viewModel.isAddingToCart {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView("Please wait...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .onChange(of: viewModel.dismissDetails) {  dissmissDetails in
            if dissmissDetails {
                dismiss()
                viewModel.dismissDetails = false
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
                            .font(.custom("Muli", size: 15))
                            .fontWeight(.light)
                            .underline()
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}


#Preview {
    ProductDetailView(product: Product(id: 3, userId: 4, title: "title", body: "Body"), viewModel: ProductsViewModel())
}


