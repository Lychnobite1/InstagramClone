//
//  PostsGridView.swift
//  Archy
//
//  Created by MURAT BAŞER on 25.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct PostsGridView: View {
    @State private var currentUserPost = [String]()
    @State private var getEmail = ""
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: true){
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]){
                    ForEach(currentUserPost,id: \.self){i in
                        WebImage(url: URL(string: i))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125,height: 125)
                        
                    }
                }.padding(.horizontal,5)
                    .padding(.vertical,5)
            }
        }
        .onAppear{
            if let mail = Auth.auth().currentUser {
                self.getEmail = mail.email ?? ""
                print(self.getEmail)
            }
            fetchDataForUser(email: getEmail)
        }
    }
    func fetchDataForUser(email:String) {
        let db = Firestore.firestore()
        db.collection("post").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if error != nil {
                print("getDocuments error")
            }
            else {
                for i in snapshot!.documents {
                    let data = i.data()
                    print(data)
                    print("**************")
                    self.currentUserPost.append(data["imageURL"] as! String)
                }
            }
        }
    }
}

struct PostsGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostsGridView()
    }
}
