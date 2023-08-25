//
//  LoginView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var mail = ""
    @State private var password = ""
    @State private var message = ""
    @ObservedObject var authModel = AuthModel()
    //@Binding var isLogin : Bool
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing: 35){
                    TextField("Email", text: $mail)
                        .padding(15)
                        .border(.black.opacity(0.7))
                        .background(.blue.opacity(0.01))
                        .padding(.horizontal,20)
                    SecureField("Password", text: $password)
                        .padding(15)
                        .border(.black.opacity(0.7))
                        .background(.blue.opacity(0.01))
                        .padding(.horizontal,20)
                    HStack(spacing: 50){
                        Button{
                            // sign in
                            if mail != "" && password != "" {
                                self.authModel.signIn(mail: mail, password: password)
                            }
                            else {
                                message = "There is/are empty place"
                            }
                            self.mail = ""
                            self.password = ""
                        }label: {
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.system(size: 21))
                                .padding(10)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: 353)
                        .background(Color("ColorGrayLight"))
                        .cornerRadius(10)
                        .background(
                            NavigationLink(destination: MainView(),isActive: $authModel.isLoggin) {
                                EmptyView()
                            }
                        )
                        
                        
                    }
                }
                VStack{
                    Text(message)
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                }.offset(y:25)
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
