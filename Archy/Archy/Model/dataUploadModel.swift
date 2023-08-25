//
//  dataUploadModel.swift
//  Archy
//
//  Created by MURAT BAŞER on 22.08.2023.
//

import Foundation
import SwiftUI
import UIKit
import Firebase
import FirebaseStorage
class FirebaseModel : ObservableObject {
    @Published var postDatas = [Post]()
    @Published var profilPhoto = String()
    @Published var PostCellProfil = [String]()
    func getData() {
         let firestoreDatabase = Firestore.firestore()
         firestoreDatabase.collection("post").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
             if error != nil {
                print("error error")
             }
             else {
                 if snapshot != nil {
                     self.postDatas.removeAll(keepingCapacity: false)
                     for i in snapshot!.documents {
                         let documentID = i.documentID
                         if let imageURL = i.get("imageURL") as? String {
                                 if let descrip = i.get("description") as? String {
                                     if let email = i.get("email") as? String {
                                         if let like = i.get("like") as? Int {
                                             if let username = i.get("username") as? String {
                                                 self.postDatas.append(Post(username: username, mail: email, image: imageURL, descrip: descrip, likeCount: like))
                                             }
                                         }
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
    }
    
    
    func deleteProfilPhoto(mail:String) {
        let firestoreDatabase = Firestore.firestore()
        let query = firestoreDatabase.collection("profil").whereField("email", isEqualTo: mail)
        query.getDocuments { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                for i in snapshot!.documents {
                    let documentID = i.documentID
                    let documentReferance = firestoreDatabase.collection("profil").document(documentID)
                    documentReferance.delete { (error) in
                        if error != nil {
                            print("delete error")
                        }
                        else {
                            print("profil foto silindi")
                        }
                    }
                }
            }
        }
    }
    
    func uploadProfilPhoto(image:UIImage,mail:String){
        deleteProfilPhoto(mail: mail)
        
        // yeni resim yükleme
        let firebaseStorage = Storage.storage()
        let storeReferance = firebaseStorage.reference()
        let mediaFolder = storeReferance.child("profilPhoto")
        if let data = image.jpegData(compressionQuality: 0.5) {
            let imageRef = mediaFolder.child("\(mail).jpg")
            imageRef.putData(data,metadata: nil) { (metadata, error) in
                if error != nil {
                    print("putData error")
                }
                else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            // database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReferance : DocumentReference?
                            let firestoreData = ["imageURL":imageURL,"email":mail] as [String : Any]
                            firestoreReferance = firestoreDatabase.collection("profil").addDocument(data: firestoreData,completion: { (error) in
                                if error != nil {
                                    print("error")
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
    func getProfilPhoto(email:String){
        let firebaseDatabase = Firestore.firestore()
        firebaseDatabase.collection("profil").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                if let document = snapshot?.documents.first, let imageURL = document.data()["imageURL"] as? String {
                    self.profilPhoto = imageURL
                }
            }
        }
        
    }
    /*
    func getProfilPhoto() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("profil").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("getprofilphoto error")
            }
            else {
                if let document = snapshot?.documents.first, let imageURL = document.data()["imageURL"] as? String {
                    self.profilPhoto = imageURL
                }
                /*
                if snapshot != nil {
                    for i in snapshot!.documents {
                        if let imageURL = i.get("imageURL") as? String {
                            self.profilPhoto = imageURL
                        }
                    }
                }
                */
            }
        }
    }
    */
    
}
