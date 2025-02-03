////
////  ChartView.swift
////  MarketList
////
////  Created by Lucas Amorim on 24/01/25.
////
//
//import Charts
//import SwiftUICore
//import DGCharts



//struct ChartView: View {
//    @State private var lowerLimit: Double = 100.0
//    @State private var upperLimit: Double = 200.0
//
//    @Binding var shoppingList: [(name: String, price: Double)] // Recebe a lista de compras
//    @State private var totalCost: Double = 0.0
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Gráfico de Barras com base nos itens da lista
//                BarChartView
//                .onAppear {
//                    updateTotalCost()
//                }
//
//                // Controle de limites
//                VStack {
//                    HStack {
//                        Text("Limite Inferior: \(Int(lowerLimit))")
//                        Slider(value: $lowerLimit, in: 0...300, step: 10)
//                    }
//                    HStack {
//                        Text("Limite Superior: \(Int(upperLimit))")
//                        Slider(value: $upperLimit, in: 0...300, step: 10)
//                    }
//                }
//                .padding()
//
//                // Total cost para exibição
//                Text("Total: \(String(format: "$%.2f", totalCost))")
//                    .font(.title)
//                    .foregroundColor(self.getAccentColor(for: totalCost))
//
//                Spacer()
//            }
//            .navigationTitle("Gráfico de Gastos")
//        }
//    }
//
//    // Função para determinar a cor com base no valor
//    private func getAccentColor(for value: Double) -> Color {
//        if value > upperLimit {
//            return .red
//        } else if value > lowerLimit {
//            return .orange
//        } else {
//            return .green
//        }
//    }
//
//    // Função para atualizar o custo total
//    private func updateTotalCost() {
//        totalCost = shoppingList.reduce(0) { $0 + $1.price }
//    }
//}
//
//#Preview {
//    ChartView(shoppingList: )
//}
