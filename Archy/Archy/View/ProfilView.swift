//
//  ProfilView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct ProfilView: View {
    @State private var getUsername = ""
    @State private var postCount = 0
    @State private var getEmail = ""
    @State private var currentUserPost = [String]()
    @ObservedObject var ViewModel = FirebaseModel()
    var body: some View {
        NavigationStack{
            VStack{
                ProfilHeaderView()
                HStack(spacing: 40){
                    VStack{
                        if let url = URL(string: ViewModel.profilPhoto){
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 100,height: 100)
                                .clipShape(Circle())
                        }
                        else {
                            Image("nofoto")
                                .resizable()
                                .frame(width: 100,height: 100)
                                .clipShape(Circle())
                        }
                        Text(getUsername)
                    }
                    VStack{
                        
                        HStack(spacing: 20){
                            VStack(alignment: .center, spacing: 8){
                                Text("Posts")
                                // gönderi sayısı
                                Text("\(postCount)")
                            }
                            VStack(alignment: .center, spacing: 8){
                                Text("Followers")
                                Text("0")
                            }
                            VStack(alignment: .center, spacing: 8){
                                Text("Following")
                                Text("0")
                            }
                        }.offset(y:-10)
                    }
                }
                Spacer()
                Text("Posts")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .offset(x:-140)
                    .padding()
                PostsView()
                Spacer()
               
                
                
            }
            .onAppear{
                if let user = Auth.auth().currentUser {
                    if let username = UserDefaults.standard.string(forKey: user.uid){
                        self.getUsername = username
                    }
                    
                }
                
                if let mail = Auth.auth().currentUser {
                    self.getEmail = mail.email ?? ""
                    print(self.getEmail)
                }
                self.getDocumentForUser(email: getEmail)
                self.fetchDataForUser(email: getEmail)
                self.ViewModel.getProfilPhoto(email: getEmail)
            }

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
    
    func getDocumentForUser(email:String) {
        let db = Firestore.firestore()
        db.collection("post").whereField("email", isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if error != nil {
                    print("getDocument error")
                }
                else {
                    self.postCount = snapshot?.documents.count ?? 0
                }
            }
    }
    
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
