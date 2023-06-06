//
//  SplitBillView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 31/05/2023.
//

import SwiftUI

struct SplitBillView: View {
    @Environment(\.dismiss) var dismiss
    
//    @FocusState private var amountIsFocused: Bool
    
    var billAmount: Double
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    let tipPercentages = [10, 15, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount / 100 * tipSelection
        let totalAmount = billAmount + tipValue
        return totalAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
//                        .keyboardType(.decimalPad)
//                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much would you like to tip?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                } header: {
                    Text("Total")
                }
            }
            .navigationTitle("Split the bill")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    Button("Done") {
//                        amountIsFocused = false
//                    }
//                }
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Cancel") {
                                dismiss()
                            }
//                            .font(.title)
//                            .padding()
//                            .background(.black)
                }
            }
        }
    }
}

struct SplitBillView_Previews: PreviewProvider {
    static var previews: some View {
        SplitBillView(billAmount: 10)
    }
}
