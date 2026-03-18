//
//  RegisterView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var localError: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            PasswordFieldView(title: "Password", text: $password)
            PasswordFieldView(title: "Confirm Password", text: $confirmPassword)
            
            if !localError.isEmpty {
                Text(localError)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button("Sign Up") {
                registerUser()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.black)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
    
    func registerUser() {
        guard !email.isEmpty, !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            localError = "Please fill in all fields."
            return
        }
        
        guard password == confirmPassword else {
            localError = "Passwords do not match."
            return
        }
        
        let success = authViewModel.register(email: email, username: username, password: password)
        if success {
            dismiss()
        } else {
            localError = authViewModel.errorMessage
        }
    }
}

#Preview {
    RegisterView()
}
