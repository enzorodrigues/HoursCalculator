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
        VStack(spacing: 20) {
            
            Text("Calculadora de Tempo")
                .font(.title)
                .bold()
            
            timeInputs
            
            
            Button {
                viewModel.addLine()
            } label: {
                Label("Adicionar Linha", systemImage: "plus.circle")
            }
            
            buttonStack
            
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
    
    // MARK: - Inputs
    
    private var timeInputs: some View {
        ScrollView {
            ForEach(viewModel.timeInputs.indices, id: \.self) { index in
                inputLabels(index: index)
                    .padding(.horizontal)
            }
        }
    }
    
    private func inputLabels(index: Int) -> some View {
        HStack {
            Text("Tempo \(index + 1):")
            
            TextField("HH:mm:ss", text: $viewModel.timeInputs[index])
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focusedIndex, equals: index)
                .onChange(of: focusedIndex) { _, newFocus in
                    onChangeFocusIndex(newFocus: newFocus, index: index)
                }
                .onChange(of: viewModel.timeInputs[index]) { _,  newValue in
                    viewModel.formatWhileTyping(newValue, for: index)
                }
        }
    }
    
    // MARK: - Buttons
    
    private var buttonStack: some View {
        VStack(spacing: 12) {
            
            defaultButtons
            
            if !viewModel.result.isEmpty {
                saveButton
            }
        }
    }
    
    private var defaultButtons: some View {
        HStack(spacing: 20) {
            Button("Somar") {
                viewModel.calculate(operation: .add, lastIndexUpdated: focusedIndex)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Subtrair") {
                viewModel.calculate(operation: .subtract, lastIndexUpdated: focusedIndex)
            }
            .buttonStyle(.bordered)
            
            Button("Limpar") {
                focusedIndex = nil
                viewModel.clearAll()
            }
            .buttonStyle(.bordered)
            .disabled(focusedIndex != nil)
        }
    }
    
    private var saveButton: some View {
        Button("Guardar") {
            focusedIndex = nil
            viewModel.saveResult()
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .disabled(focusedIndex != nil)
    }
    
    // MARK: - Functions
    
    private func onChangeFocusIndex(newFocus: Int?, index: Int) {
        if newFocus != index, !viewModel.timeInputs[index].isEmpty {
            viewModel.completeTimeIfNeeded(for: index)
        }
    }
}


struct HoursCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        HoursCalculatorView()
    }
}
