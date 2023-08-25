//
//  UploadHeaderView.swift
//  Archy
//
//  Created by MURAT BAŞER on 22.08.2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct UploadHeaderView: View {
    @Binding var isPickerShow : Bool
    @Binding var selectedImage : UIImage?
    @Binding var description : String
    @State private var getUsername = ""
    @State private var getEmail = ""
    var body: some View {
        HStack{
            Button{
                self.isPickerShow = true
            }label: {
                Image(systemName: "camera")
                    .font(.system(size: 23))
            }
            .sheet(isPresented: $isPickerShow){
                ImagePicker(selectedImage: $selectedImage, isPickerShow: $isPickerShow)
            }
            Spacer()
            Button{
                // SHARE ACTION
                self.uploadData(id: UUID(), image: selectedImage!, descrip: description,username: getUsername,like: 0)
            }label: {
                Text("Share")
                    .font(.system(size: 21))
            }
            .disabled(description == "")
            
            
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                if let username = UserDefaults.standard.string(forKey: user.uid) {
                    self.getUsername = username
                }
            }
            
            if let currentUser = Auth.auth().currentUser {
                let userEmail = currentUser.email
                self.getEmail = userEmail!
            }
        }
    }
    func uploadData(id : UUID,image : UIImage,descrip : String,username : String,like : Int) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("images")
        if let data = image.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data,metadata: nil) { (metadata, error) in
                if error != nil {
                    print("putData error")
                }
                else {
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            // database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReferance : DocumentReference?
                            let firestoreData = ["imageURL":imageURL,"description":descrip,"username":self.getUsername,"email":getEmail,"like":0,"date":FieldValue.serverTimestamp()] as [String : Any]
                            firestoreReferance = firestoreDatabase.collection("post").addDocument(data: firestoreData,completion: { (error) in
                                if error != nil {
                                    print("addDocument error")
                                }
                                else {
                                    print("yükleme başarılı")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}

 

struct UploadHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UploadHeaderView(isPickerShow: .constant(false), selectedImage: .constant(nil), description: .constant(""))
    }
}
