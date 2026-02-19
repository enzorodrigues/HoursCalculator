//
//  TimeCalculatorView.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

import SwiftUI

struct TimeCalculatorView: View {
    
    @StateObject private var viewModel = TimeCalculatorViewModel()
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Cálculo de tempo de treino")
                .font(.title)
                .bold()
            
            // Entrada
            timeInput("Horário de Entrada", selector: $viewModel.entryTime)
            
            // Saída
            timeInput("Horário de Saída", selector: $viewModel.exitTime)
            

            Divider()
            
            // Cardios
            VStack(alignment: .leading, spacing: 20) {
                cardioHeader
                
                cardioBody
            }
            
            Divider()
            
            resultSection
                .padding(.all)
            
            Spacer()
            
        }
        .padding()
        .background()
        .onTapGesture {
            focusedIndex = nil
        }
    }
    
    // MARK: - Time Input
    
    private func timeInput(_ title: String, selector: Binding<Date>) -> some View {
        HStack {
            Text(title)
            Spacer()
            DatePicker(
                "",
                selection: selector,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.compact)
        }
    }
    
    // MARK: - Cardio Section
    
    private var cardioHeader: some View {
        HStack {
            Text("Cardios")
                .font(.headline)
            
            Spacer()
            
            Button("Adicionar", systemImage: "plus.circle") {
                viewModel.addBreak()
            }
        }
    }
    
    private var cardioBody: some View {
        ScrollView {
            ForEach(viewModel.breaks.indices, id: \.self) { index in
                cardioInput(index)
            }
        }
        .frame(minHeight: 80, maxHeight: 130)
    }
    
    private func cardioInput(_ index: Int) -> some View {
        HStack {
            TimeMaskedTextField(
                title: "Tempo \(index + 1):",
                placeholder: "HH:mm:ss",
                text: $viewModel.breaks[index].duration,
                focusedField: $focusedIndex,
                index: index
            )
            
            Button {
                withAnimation {
                    viewModel.removeBreak(at: index)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.trailing, 12)
    }
    
    // MARK: - Result section
    
    private var resultSection: some View {
        VStack(alignment: .center) {
            Button("Calcular") {
                focusedIndex = nil
                viewModel.calculate(lastIndexUpdated: focusedIndex)
            }
            .buttonStyle(.borderedProminent)
            
            if !viewModel.result.isEmpty {
                Text("Tempo restante: \(viewModel.result)")
                    .font(.title2)
                    .bold()
                    .padding()
            }
        }
    }
}

#Preview {
    TimeCalculatorView()
}
