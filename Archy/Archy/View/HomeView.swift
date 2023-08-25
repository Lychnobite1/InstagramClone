//
//  HomeView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI
struct HomeView: View {
    @State private var likeCount = 0
    @ObservedObject var ViewModel = FirebaseModel()
    var body: some View {
            VStack{
                List{
                    ForEach(ViewModel.postDatas,id: \.id) {i in
                        PostCellView(post: i)
                    }
                }.listStyle(.inset)
            }
             .onAppear{
                 ViewModel.getData()
             }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
