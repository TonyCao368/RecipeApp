//
//  LoginView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding(.top, 36)
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            PasswordFieldView(title: "Password", text: $password)
            
            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundStyle(Color.red)
                    .font(.footnote)
            }
            Button("Login") {
                authViewModel.login(username: username, password: password)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.black)
            .cornerRadius(8)
            
            NavigationLink("Create an Account") {
                RegisterView()
            }
            Spacer()
        }
        
    }
}

#Preview {
    LoginView()
}
