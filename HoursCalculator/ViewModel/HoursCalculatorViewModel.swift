//
//  HoursCalculatorViewModel.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 16/02/26.
//

import Foundation

enum Operation {
    case add
    case subtract
}

class HoursCalculatorViewModel: ObservableObject {
    
    @Published var timeInputs: [String] = ["", ""]
    @Published var result: String = ""
    
    // MARK: - Formatação durante digitação
    
    func formatWhileTyping(_ input: String, for index: Int) {
        let numbers = input.filter { $0.isNumber }
        let limited = String(numbers.prefix(6))
        
        var h = ""
        var m = ""
        var s = ""
        
        if limited.count >= 1 {
            h = String(limited.prefix(2))
        }
        if limited.count >= 3 {
            m = String(limited.dropFirst(2).prefix(2))
        }
        if limited.count >= 5 {
            s = String(limited.dropFirst(4).prefix(2))
        }
        
        // Limite apenas para minutos e segundos
        if let minute = Int(m), minute > 59 {
            m = "59"
        }
        if let second = Int(s), second > 59 {
            s = "59"
        }
        
        var formatted = h
        
        if limited.count > 2 {
            formatted += ":" + m
        }
        if limited.count > 4 {
            formatted += ":" + s
        }
        
        timeInputs[index] = formatted
    }
    
    // MARK: - Completar ao sair do campo
    
    func completeTimeIfNeeded(for index: Int) {
        let input = timeInputs[index]
        let parts = input.split(separator: ":").map { String($0) }
        
        var hours = parts.count > 0 ? parts[0] : "0"
        var minutes = parts.count > 1 ? parts[1] : "0"
        var seconds = parts.count > 2 ? parts[2] : "0"
        
        // Garante 2 dígitos para minutos e segundos
        hours = String(format: "%02d", Int(hours) ?? 0)
        minutes = String(format: "%02d", Int(minutes) ?? 0)
        seconds = String(format: "%02d", Int(seconds) ?? 0)
        
       timeInputs[index] = "\(hours):\(minutes):\(seconds)"
    }
    
    // MARK: - Cálculo
    
    private func calculateTime(operation: Operation) {
        var totalSeconds = 0
        
        if case .subtract = operation {
            timeInputs = timeInputs.sorted(by: >)
        }
        
        for (index, input) in timeInputs.enumerated() {
            let components = input.split(separator: ":")
            
            if components.count == 3,
               let hours = Int(components[0]),
               let minutes = Int(components[1]),
               let seconds = Int(components[2]) {
                
                let valueInSeconds = hours * 3600 + minutes * 60 + seconds
                
                if operation == .add {
                    totalSeconds += valueInSeconds
                } else {
                    if index == 0 {
                        totalSeconds = valueInSeconds
                    } else {
                        totalSeconds -= valueInSeconds
                    }
                }
            }
        }
        
        let hours = abs(totalSeconds / 3600)
        let minutes = abs((totalSeconds % 3600) / 60)
        let seconds = abs(totalSeconds % 60)
        
        result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: - Ações
    
    func addLine() {
        timeInputs.append("")
    }
    
    func clearAll() {
        timeInputs = ["", ""]
        result = ""
    }
    
    func saveResult() {
        guard !result.isEmpty else { return }
        timeInputs = [result, ""]
        result = ""
    }
    
    func calculate(operation: Operation, lastIndexUpdated: Int?) {
        if let index = lastIndexUpdated, timeInputs[index].count < 6 {
            completeTimeIfNeeded(for: index)
        }
        calculateTime(operation: operation)
    }
    
}

