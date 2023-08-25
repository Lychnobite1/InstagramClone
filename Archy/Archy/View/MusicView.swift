//
//  MusicView.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import SwiftUI

struct MusicView: View {
    @State private var musics = ["Mr.Kitty - After Dark","Mac DeMarco - Chamber Of Reflection","Slipknot - Psychosocial"]
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: [GridItem(.flexible())]){
                ForEach(musics,id: \.self){i in
                    HStack{
                        Image(systemName: "music.note")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                        Text(i)
                            .foregroundColor(.black)
                    }
                    .padding(10)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(14)
                }
            }
        }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}
