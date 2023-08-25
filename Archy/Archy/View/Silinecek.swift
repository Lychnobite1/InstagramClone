//
//  Silinecek.swift
//  Archy
//
//  Created by MURAT BAŞER on 22.08.2023.
//

import SwiftUI

struct Silinecek: View {
    @ObservedObject var ViewModel = FirebaseModel()
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false) {
                List {
                    ForEach(ViewModel.postDatas,id: \.id) {i in
                        Text(i.username)
                    }
                }
            }
        }
        .onAppear{
            ViewModel.getData()
        }
    }
}

struct Silinecek_Previews: PreviewProvider {
    static var previews: some View {
        Silinecek()
    }
}
