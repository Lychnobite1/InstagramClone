//
//  RegisterView.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var mail = ""
    @State private var password = ""
    @State private var passwordAgain = ""
    @State private var message = ""
    @ObservedObject var authModel = AuthModel()

    var body: some View {
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
                SecureField("Again Password", text: $passwordAgain)
                    .padding(15)
                    .border(.black.opacity(0.7))
                    .background(.blue.opacity(0.01))
                    .padding(.horizontal,20)
                HStack(spacing: 50){
                    Button{
                        // sign up
                        if password == "" || passwordAgain == "" || mail == "" {
                            message = "There is/are empty place!"
                        }
                        else if password != passwordAgain {
                            message = "passwords is different"
                        }
                        else {
                            authModel.signUp(mail: mail, password: password)
                            message = "success is sign up!"
                        }
                        self.mail = ""
                        self.password = ""
                        self.passwordAgain = ""
                    }label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .font(.system(size: 21))
                            .padding(10)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: 353)
                    .background(Color("ColorGrayLight"))
                    .cornerRadius(10)
                    
                    
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
