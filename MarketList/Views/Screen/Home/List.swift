//
//  List.swift
//  MarketList
//
//  Created by Lucas Amorim on 24/01/25.
//

import SwiftUI

struct ListView: View {
    @State private var itemName: String = ""
    @State private var itemPrice: String = ""
    @State private var shoppingList: [(name: String, price: Double)] = []
    @State private var totalCost: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var editingIndex: Int?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               
                HStack {
                    TextField("Nome do item", text: $itemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 0, maxWidth: .infinity)

                    TextField("Preço", text: $itemPrice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                .padding(.horizontal)

                
                Button(action: {
                    addItem()
                }) {
                    Text("Adicionar Item")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)

               
                List {
                    ForEach(Array(shoppingList.enumerated()), id: \.offset) { index, item in
                        HStack {
                            Text(item.name)
                                .fontWeight(.semibold)

                            Spacer()

                            Text(String(format: "$%.2f", item.price))
                                .foregroundColor(.gray)

                            
                            Button(action: {
                                startEditing(at: index)
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }

                            
                            Button(action: {
                                deleteItem(at: IndexSet([index]))
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                }

               
                HStack {
                    Text("Total:")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer()

                    Text(String(format: "$%.2f", totalCost))
                        .font(.title2)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Lista de Compras")
        }
    }

    private func addItem() {
        guard !itemName.isEmpty, let price = Double(itemPrice) else { return }

        shoppingList.append((name: itemName, price: price))
        totalCost += price
        itemName = ""
        itemPrice = ""
    }

    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            totalCost -= shoppingList[index].price
        }
        shoppingList.remove(atOffsets: offsets)
    }

    private func startEditing(at index: Int) {
        editingIndex = index
        itemName = shoppingList[index].name
        itemPrice = String(format: "%.2f", shoppingList[index].price)
        isEditing = true
    }

    private func saveEdit() {
        guard let index = editingIndex, let price = Double(itemPrice) else { return }

       
        shoppingList[index].name = itemName
        shoppingList[index].price = price

       
        totalCost = shoppingList.reduce(0) { $0 + $1.price }

     
        isEditing = false
        itemName = ""
        itemPrice = ""
        editingIndex = nil
    }

    private func cancelEdit() {
       
        isEditing = false
        itemName = ""
        itemPrice = ""
        editingIndex = nil
    }
}

#Preview {
    ListView()
}
