//
//  UploadView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI
import Firebase
struct UploadView: View {
    @State private var isPickerShow = false
    @State private var selectedImage : UIImage?
    @State private var description = ""
    @State private var username = ""
    @State private var likeCount = 0
    @State private var toggleState = false
    var body: some View {
            VStack{
                UploadHeaderView(isPickerShow: $isPickerShow, selectedImage: $selectedImage, description: $description)
                    .padding(.horizontal)
                HStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                    }
                    else {
                        Image("nofoto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 110)
                            
                    }
                    TextEditor(text: $description)
                        .frame(width: 250,height: 100)
                        .border(Color.gray.opacity(0.1))
                        .overlay(
                            Text("Description")
                                .offset(x:-75,y: -30)
                                .opacity(description.isEmpty ? 0.5 : 0)
                        )
                }
                .padding()
                Spacer()
                List{
                    HStack{
                        Text("Tag people")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .opacity(0.5)
                    }
                    HStack{
                        Text("Audience")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .opacity(0.5)
                    }
                    VStack{
                        HStack{
                            Text("Add location")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .opacity(0.5)
                        }
                        ButtonView()
                            .padding(.vertical,5)
                            
                            
                    }
                    VStack{
                        HStack{
                            Text("Add music")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .opacity(0.5)
                        }
                        MusicView()
                    }
                    VStack(alignment: .leading){
                        Text("Post the other Instagram account")
                        Toggle("Share To Facebook", isOn: $toggleState)
                        Toggle("Share To Tumblr", isOn: $toggleState)
                        Toggle("Share To Snapchat", isOn: $toggleState)
                        
                    }
                    
                
                }
                .listStyle(.inset)
                
            }
            .onAppear{
                if let user = Auth.auth().currentUser {
                    if let getUsername = UserDefaults.standard.string(forKey: user.uid) {
                        self.username = getUsername
                    }
                }
                

            }
         
            
            

    }
}



struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
