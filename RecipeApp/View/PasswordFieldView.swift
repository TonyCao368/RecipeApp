//
//  PasswordFieldView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI

struct PasswordFieldView: View {
    let title: String
    @Binding var text: String
    @State var isSecure:Bool = true
    
    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            Button(isSecure ? "Show" : "Hide") {
                isSecure.toggle()
            }
            .font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

