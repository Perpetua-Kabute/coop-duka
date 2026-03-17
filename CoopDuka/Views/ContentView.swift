//
//  ContentView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(edges: .all)
            if appState.hasLoggedIn {
                
                NavigationStack{
                    HomeView()
                }
            }else{
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
