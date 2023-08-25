//
//  ButtonView.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import SwiftUI

struct ButtonView: View {
    @State private var locations = ["İstanbul","İzmir","Ankara","Antalya","Samsun","Malatya"]
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: [GridItem(.flexible())]){
                ForEach(locations,id: \.self){i in
                    Button{
                        
                    }label: {
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

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
