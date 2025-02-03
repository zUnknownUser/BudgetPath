//
//  LoginView.swift
//  MarketList
//
//  Created by Lucas Amorim on 03/02/25.
//

import SwiftUI

struct LoginView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var dragAmount: CGFloat = 0
    @State private var isCreatingAccount = false
    @State private var password: String = ""
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [
                Color(hex: "#BF00FF"),
                Color.black
            ], center: .top, startRadius: 100, endRadius: 415)
            .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
               
                HStack {
                    Image(systemName: "wallet.bifold")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)

                    Text("BudgetPath")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding()
                }
                .padding(.top, 20)

                Text("Sign Up your account")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text("Enter your personal data to create your account.")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding()

                Button {
                    print("Tapped here to login with Google")
                } label: {
                    HStack {
                        Text("Google")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                    }
                    .padding()
                    .cornerRadius(10)
                }
                .padding(.bottom, 20)

                HStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("OR")
                        .foregroundStyle(.gray)
                        .font(.system(size: 18))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal, 20)

                VStack(alignment: .leading) {
                    Text("Username")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    TextField("Enter your Username", text: $firstName)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                VStack(alignment: .leading) {
                    Text("Password")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    SecureField("**********", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                VStack {
                    Text("Swipe right to create account")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .padding(.top, 20)
                        .fontWeight(.semibold)

                    GeometryReader { geometry in
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(dragAmount > 0 ? Color(hex: "#BF00FF").opacity(0.8) : Color.white.opacity(0.3))
                                .frame(width: dragAmount, height: 50)
                                .cornerRadius(10)
                            
                            HStack {
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .offset(x: dragAmount)
                            }
                            .padding(.horizontal)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if value.translation.width > 0 {
                                            dragAmount = min(value.translation.width, geometry.size.width)
                                        }
                                    }
                                    .onEnded { value in
                                        if dragAmount > geometry.size.width * 0.6 {
                                            isCreatingAccount = true
                                            
                                            loginViewModel.actionLogin(email: email, password: password, name: firstName) { success in
                                                if success {
                                                    print("Account created successfully")
                                                } else {
                                                    print("Failed to create account")
                                                }
                                            }
                                        }
                                        dragAmount = 0
                                    }
                            )
                        }
                    }
                    .frame(height: 50)
                    .padding(.top, 30)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
              
                if !loginViewModel.errorMessage.isEmpty {
                    Text(loginViewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding()
                }
                
                if !loginViewModel.user.isEmpty {
                    Text(loginViewModel.user)
                        .foregroundColor(.green)
                        .font(.footnote)
                        .padding()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let red, green, blue: Double

        if hex.count == 6 {
            red   = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue  = Double(int & 0xFF) / 255.0
        } else {
            red = 0.0
            green = 0.0
            blue = 0.0
        }

        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    LoginView()
}
