//
//  SettingsView.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import SwiftUI
import Firebase
struct SettingsView: View {
    @ObservedObject var authModel = AuthModel()
    @State private var toggleState = false
    @State private var showExitAlert = false
    @State private var isExit = false
    @State private var username = ""
    @State private var isShowImagePicker = false
    @State private var selectedImage : UIImage?
    @Environment(\.presentationMode) var pm
    @ObservedObject var ViewModel = FirebaseModel()
    @State private var getEmail = ""
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    Spacer()
                    VStack(spacing: 15){
                        ZStack{
                            if selectedImage != nil {
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .frame(width: 110,height: 110)
                                    .clipShape(Circle())
                            }
                            else {
                                Image("nofoto")
                                    .resizable()
                                    .frame(width: 110,height: 110)
                                    .clipShape(Circle())
                            }
                            Button{
                                // image picker
                                self.isShowImagePicker = true
                            }label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            }.offset(x:60,y:40)
                                .sheet(isPresented: $isShowImagePicker,onDismiss: nil){
                                    ImagePicker(selectedImage: $selectedImage, isPickerShow: $isShowImagePicker)
                                }
                        }
                        Button{
                            // profil foto save.
                            if selectedImage != nil {
                                self.ViewModel.uploadProfilPhoto(image: selectedImage!, mail: getEmail)
                            }
                            else {
                                print("resim seçilmedi")
                            }
                        }label: {
                            Text("Kaydet")
                        }
                    }
                    Spacer()
                }
                Divider()
                TextField("Username", text: $username)
                Divider()
                Toggle("Notification", isOn: $toggleState)
                Divider()
                Button{
                    // exit action
                    self.showExitAlert = true
                }label: {
                    Text("Exit")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(width: 330,height: 40)
                .background(.red)
                .cornerRadius(30)
                .offset(y:20)
                .alert(isPresented: $showExitAlert){
                    Alert(title: Text("Exit"),message: Text("Are you sure want to exit?") ,primaryButton: .destructive(Text("Evet"),action: {
                        self.authModel.logout()
                        self.isExit = true
                    }), secondaryButton: .cancel(Text("Vazgeç")))
                }
                NavigationLink(destination: ContentView(), isActive: $isExit){
                    EmptyView()
                }

                Spacer()
                
                
                
            }.padding(40)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        // save action
                        if username != "" {
                            if let user = Auth.auth().currentUser {
                                UserDefaults.standard.set(username, forKey: user.uid)
                            }
                        }
                        
                        self.pm.wrappedValue.dismiss()
                    }label: {
                        Text("Save")
                    }
                }
            }
            .onAppear{
                if let mail = Auth.auth().currentUser {
                    self.getEmail = mail.email ?? ""
                    print(self.getEmail)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
