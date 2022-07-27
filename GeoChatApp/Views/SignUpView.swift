//
//  SignUpView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var username = ""
    
    @EnvironmentObject var AuthViewModel : AuthViewModel
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack{
                TextField("Username", text:$username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                TextField("Email Address", text:$email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password",text:$password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action:{
                    
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    AuthViewModel.singUp(email: email, password: password, username:username)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width:200,height:50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
                
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Account")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
