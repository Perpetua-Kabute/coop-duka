//
//  ProgressView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//
import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()

        ProgressView("Please wait...")
            .padding()
            .background(Color.white)
            .cornerRadius(10)
    }
}


