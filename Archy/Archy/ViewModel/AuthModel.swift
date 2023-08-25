//
//  AuthModel.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import Foundation
import Firebase

class AuthModel : ObservableObject {
    @Published var isLoggin = false
    func signIn(mail:String,password:String){
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            if error != nil {
                print("giriş hatalı")
            }
            else {
                print("Success is Login")
                self.isLoggin = true
            }
        }
    }
    func signUp(mail:String,password:String) {
        Auth.auth().createUser(withEmail: mail, password: password) { (result, error) in
            if error != nil {
                print("kayıt olma hatalı")
            }
            else {
                print("kayıt başarılı.")
            }
        }
    }
    func logout() {
        do {
            try Auth.auth().signOut()
            print("çıkış başarılı..")
        }
        catch {
            print("çıkış işleminde hata oluştu")
        }
    }
    
}



