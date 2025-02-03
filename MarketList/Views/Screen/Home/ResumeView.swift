//
//  ResumeView.swift
//  MarketList
//
//  Created by Lucas Amorim on 24/01/25.
//

import SwiftUI
struct ResumeView: View {
    var totalGasto: Double
    var mes: String
    
    var body: some View {
        VStack {
            Text("Resumo de Gastos")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("Gasto Total: \(String(format: "$%.2f", totalGasto))")
                .font(.title2)
                .padding()

            Text("Mês: \(mes)")
                .font(.title3)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .navigationTitle("Resumo")
        .padding()
    }
}


#Preview {
    List {
        ResumeView(totalGasto: 250.75, mes: "Janeiro 2025");
        ResumeView(totalGasto: 230, mes: "Fevereiro 2025");
        ResumeView(totalGasto: 230, mes: "Agosto 2025");
        ResumeView(totalGasto: 230, mes: "Fevereiro 2025");
        ResumeView(totalGasto: 230, mes: "Fevereiro 2025");
    }
}
