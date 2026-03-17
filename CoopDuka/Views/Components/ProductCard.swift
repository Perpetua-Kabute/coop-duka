//
//  ProductCard.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI
 struct ProductCard: View {
    let product: Product
    let isSelected: Bool = false // remove

    private var imageURL: URL? {
        URL(string: "https://picsum.photos/seed/\(product.id)/400/400")
    }

    private var formattedPrice: String {
        let amount = (product.id % 20 + 1) * 100
        if amount >= 1000 {
            return String(format: "KES %d,%03d.00", amount / 1000, amount % 1000)
        }
        return String(format: "KES %d.00", amount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))

                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(16)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .font(.system(size: 32))
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title.capitalized)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
                    .foregroundColor(.primary)

                Text(formattedPrice)
                    .font(.system(size: 13))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}
