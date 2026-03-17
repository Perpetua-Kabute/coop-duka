//
//  CustomOutlinedTextField.swift
//  FundMoja
//
//  Created by Perpetua Kabute    on 21/05/2025.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var showPassword: Binding<Bool>?
    @Binding var errorMessage: String?
    var keyboardType = UIKeyboardType.default

    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if !title.isEmpty {
                Text(title)
                    .font(.custom("Poppins", size: 13).weight(.regular))
                    .foregroundColor(Color("TextFieldColor"))
                    .padding(.leading, 4)
            }
            
            if isSecure {
                ZStack(alignment: .trailing) {
                    if showPassword?.wrappedValue ?? false {
                        TextField(placeholder, text: $text)
                            .padding()
                            .font(.custom("Poppins", size: 12).weight(.regular))
                            .foregroundColor(Color("TextFieldColor"))
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                        
                    } else {
                        SecureField(placeholder, text: $text)
                            .padding()
                            .foregroundColor(Color("TextFieldColor"))
                            .font(.custom("Poppins", size: 12).weight(.regular))
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                    }
                    
                    Button(action: {
                        showPassword?.wrappedValue.toggle()
                    }) {
                        Image(systemName: (showPassword?.wrappedValue ?? false) ? "eye" : "eye.slash")
                            .foregroundColor(Color.coopPrimaryGreen)
                    }
                    .padding(.trailing, 16)
                }
            } else {
                TextField(placeholder, text: $text, axis: .vertical)
                    .padding()
                    .font(.custom("Poppins", size: 12).weight(.regular))
                    .foregroundColor(Color("TextFieldColor"))
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .keyboardType(keyboardType)
                    .multilineTextAlignment( TextAlignment.leading)
            }
            if let error = errorMessage{
                Text(error)
                    .font(.custom("Poppins", size: 12).weight(.regular))
                    .foregroundColor(.red)
                    .fontWeight(.light)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    Group{
        CustomTextField(title: "Name", placeholder: "Name", text: .constant(""), isSecure: true, showPassword: .constant(true), errorMessage: .constant(""))
        CustomTextField(title: "Name", placeholder: "Name", text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae nibh fermentum, dignissim orci a, tristique purus. Vivamus non tellus euismod, viverra libero vitae, tincidunt lectus. Etiam elit neque, suscipit nec sem non, molestie bibendum libero. Nam at mauris eget ipsum tempus cursus eu non lectus. Donec quam odio, malesuada tincidunt enim quis, dignissim porttitor odio. Nam nunc lacus, vehicula non felis a, placerat vestibulum mauris. Integer pretium felis velit, sit amet posuere quam sagittis vitae."), isSecure: false, showPassword: .constant(false), errorMessage: .constant(""))
    }
}
