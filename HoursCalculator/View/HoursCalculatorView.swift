//
//  HoursCalculatorView.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 16/02/26.
//

import SwiftUI

struct HoursCalculatorView: View {
    
    @StateObject private var viewModel = HoursCalculatorViewModel()
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Calculadora de Tempo")
                    .font(.title)
                    .bold()
                
                ScrollView {
                    ForEach(viewModel.timeInputs.indices, id: \.self) { index in
                        HStack {
                            Text("Tempo \(index + 1):")
                            
                            TextField("HH:mm:ss", text: $viewModel.timeInputs[index])
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($focusedIndex, equals: index)
                                .onChange(of: focusedIndex) { _, newFocus in
                                    if newFocus != index, !viewModel.timeInputs[index].isEmpty {
                                        viewModel.completeTimeIfNeeded(viewModel.timeInputs[index], for: index)
                                    }
                                }
                                .onChange(of: viewModel.timeInputs[index]) { _,  newValue in
                                    viewModel.formatWhileTyping(newValue, for: index)
                                }
                                
                        }
                        .padding(.horizontal)
                    }
                }
                
                
                Button {
                    focusedIndex = nil
                    viewModel.addLine()
                } label: {
                    Label("Adicionar Linha", systemImage: "plus.circle")
                }
                
                VStack(spacing: 12) {
                    
                    HStack(spacing: 20) {
                        Button("Somar") {
                            focusedIndex = nil
                            viewModel.calculateTime(operation: .add)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(focusedIndex != nil)
                        
                        Button("Subtrair") {
                            focusedIndex = nil
                            viewModel.calculateTime(operation: .subtract)
                        }
                        .buttonStyle(.bordered)
                        .disabled(focusedIndex != nil)
                        
                        Button("Limpar") {
                            focusedIndex = nil
                            viewModel.clearAll()
                        }
                        .buttonStyle(.bordered)
                        .disabled(focusedIndex != nil)
                    }
                    
                    if !viewModel.result.isEmpty {
                        Button("Guardar") {
                            focusedIndex = nil
                            viewModel.saveResult()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .disabled(focusedIndex != nil)
                    }
                }
                
                if !viewModel.result.isEmpty {
                    Text("Resultado: \(viewModel.result)")
                        .font(.title2)
                        .bold()
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                focusedIndex = nil
            }
        }
    }
}

struct HoursCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        HoursCalculatorView()
    }
}
