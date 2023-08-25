//
//  MainView.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack{
            TabView{
                HomeView().tabItem{
                    Label("Home", systemImage: "homekit")
                }
                UploadView().tabItem{
                    Label("Upload", systemImage: "plus.app")
                }
                ProfilView().tabItem{
                    Label("Profil", systemImage: "person.fill")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

