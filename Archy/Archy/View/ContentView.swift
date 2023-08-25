//
//  ContentView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI
import SlidingTabView
struct ContentView: View {
    @State private var tabIndex = 0
    var body: some View {
        NavigationStack {
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["Login","Register"],activeAccentColor: Color(.black),selectionBarColor: Color("ColorGrayLight"))
                Text("Archy")
                    .font(.system(size: 60))
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .offset(y:75)
                Spacer()
                if tabIndex == 0 {
                    LoginView()
                }
                else if tabIndex == 1 {
                    RegisterView()
                }
                Spacer()
            }
            .background(
                Color("ColorGreenLight").opacity(0.3)
            )
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
