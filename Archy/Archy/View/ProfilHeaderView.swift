//
//  ProfilHeaderView.swift
//  Archy
//
//  Created by MURAT BAŞER on 22.08.2023.
//

import SwiftUI

struct ProfilHeaderView: View {
    @State private var isSettingsview = false
    var body: some View {

            HStack{
                Spacer()
                Button{
                    self.isSettingsview = true
                }label: {
                    NavigationLink(destination: SettingsView()){
                        Image(systemName: "gear").font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                }
                
            }.padding(.horizontal)
        
    }
}


struct ProfilHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilHeaderView()
    }
}
