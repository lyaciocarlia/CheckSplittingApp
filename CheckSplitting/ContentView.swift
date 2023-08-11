//
//  ContentView.swift
//  CheckSplitting
//
//  Created by Iuliana Stecalovici  on 11.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var check = 0.0
    @State private var ppl = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let amountPerPerson = (check + (check/100 * Double(tipPercentage)))/Double(ppl + 2)
        return amountPerPerson
    }
    
    private var tipOption = [0, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $check, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number or people", selection: $ppl) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("TipPercentage", selection: $tipPercentage) {
                        ForEach(tipOption, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
            .navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
