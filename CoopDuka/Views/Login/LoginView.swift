//
//  LoginView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = LoginViewModel()

    

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ImageSection(geometry: geometry)
                VStack(alignment: .leading, spacing: 0) {

                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Already registered on the new platform?")
                            .font(.custom("Muli", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Text("Use your credentials to log in")
                            .font(.custom("Muli", size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 32)

                    // Username Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Username")
                            .font(.custom("Muli", size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("TextFieldColor"))

                    
                        TextField("MB30123456", text: $viewModel.username)
                            .font(.custom("Muli", size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(Color("TextFieldColor"))
                            .keyboardType(.asciiCapable)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .padding(.vertical, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("TextFieldColor")),
                                alignment: .bottom
                            )


                        if let error = viewModel.usernameError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        HStack {
                            Spacer()
                            Button("Forgot Username?") { }
                                .font(.custom("Muli", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("CoopPrimaryGreen"))
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 24)

                    // Password Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.custom("Muli", size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextFieldColor"))

                        HStack {
                            if viewModel.isPasswordVisible {
                                TextField("", text: $viewModel.password)
                                    .font(.custom("Muli", size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("TextFieldColor"))
                            } else {
                                SecureField("", text: $viewModel.password)
                                    .font(.custom("Muli", size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("TextFieldColor"))
                                   
                            }

                            Button(action: { viewModel.isPasswordVisible.toggle() }) {
                                Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color("CoopPrimaryGreen"))
                            }
                        }
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color("TextFieldColor")),
                            alignment: .bottom
                        )



                        if let error = viewModel.passwordError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        HStack {
                            Spacer()
                            Button("Forgot Password?") { }
                                .font(.custom("Muli", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("CoopPrimaryGreen"))
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 20)

                    Spacer()
                    // Login Button
                    Button(action: {
                        if viewModel.validate() {
                            viewModel.simulateLogin()

                        }
                    }) {
                        Text("Log In")
                            .font(.custom("Muli", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("CoopPrimaryGreen"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 24)
                    
                }
                .padding(.horizontal, 24)
                .frame(maxHeight: .infinity)
                .background(Color("BackgroundColor"))
            }
            
            .ignoresSafeArea(edges: .top)
        }
        .ignoresSafeArea(edges: .top)
        .overlay {
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView("Please wait...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .onChange(of: viewModel.hasLoggedIn) { loggedIn in
            appState.hasLoggedIn = viewModel.hasLoggedIn

        }
    }

    // MARK: - Image section

    private struct ImageSection: View {
        let geometry: GeometryProxy
        
        var body: some View{
            let heroHeight = geometry.size.height * 0.45
            
            ZStack {
                
                Image("login_background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: heroHeight)
                    .clipped()
                
                Color.black.opacity(0.25)
                    .frame(width: geometry.size.width, height: heroHeight)
               
                VStack(spacing: 16) {
                    Spacer()
                    Spacer()
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("Welcome to a New Banking Experience")
                            .font(.custom("Muli", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("Dream it. Achieve it.")
                            .font(.custom("Muli", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
            }
            .frame(height: heroHeight)
        }
    }

    
    

}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
