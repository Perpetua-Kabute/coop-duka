//
//  CartSuccessBanner.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//
import SwiftUI
struct CartSuccessBanner: View {
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text("Item has been added to the cart successfully.")
                .font(.custom("Muli", size: 14))
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()

            Button("OK", action: onDismiss)
                .font(.custom("Muli", size: 15))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(red: 0.16, green: 0.38, blue: 0.16))
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .padding(.top, 8)
    }
}
