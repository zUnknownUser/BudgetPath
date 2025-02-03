//
//  HomePage.swift
//  MarketList
//
//  Created by Lucas Amorim on 24/01/25.
//

import SwiftUI

struct HomePage: View {
    @State private var showConfirmation = false
    let gridOptions = [
        ("Adicionar Item", "plus.circle", { print("Adicionar Item clicado") }),
        ("Minha Lista", "list.bullet", { print("Minha Lista clicado") }),
        ("Resumo de Gastos", "chart.pie", { print("Resumo de Gastos clicado") }),
        ("Histórico de Compras", "clock.fill", { print("Histórico de Compras clicado") })
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color(.systemGray6)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 30) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80) //
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
                                    .shadow(radius: 5)

                                VStack(alignment: .leading) {
                                    Text("Usuário: John Doe")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)

                                    Text("ID: 123456")
                                        .font(.body) 
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 6)
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 40)

                        
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(gridOptions, id: \ .0) { option in
                                Button(action: {
                                    option.2()
                                }) {
                                    VStack {
                                        Image(systemName: option.1)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.green)

                                        Text(option.0)
                                            .font(.footnote)
                                            .foregroundColor(.black)
                                            .padding(.top, 5)
                                    }
                                    .frame(width: 120, height: 120)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                }
                            }
                        }
                        .padding()

                        Spacer()
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
                   
            }
            
            ListView()
                .tabItem {
                    Label("Lista", systemImage: "list.bullet")
                }
            
            ResumeView(totalGasto: 120, mes: "Janeiro")
                .tabItem {
                    Label("Resumo", systemImage: "chart.pie")
                        .shadow(radius: 5)
                        
                }

            Text("Configurações")
                .tabItem {
                    Label("Configurações", systemImage: "gear")
                        .shadow(radius: 5)
                }
        }
        .accentColor(.green)
    }
} 

#Preview {
    HomePage()
}
