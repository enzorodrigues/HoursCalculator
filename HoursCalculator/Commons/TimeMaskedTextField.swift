//
//  TimeMaskedTextField.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

import SwiftUI

struct TimeMaskedTextField: View {
    
    let title: String
    let placeholder: String
    
    @Binding var text: String
    @FocusState.Binding var focusedField: Int?
    
    let index: Int
    
    var body: some View {
        HStack {
            Text(title)
            
            TextField(placeholder, text: $text)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: index)
                .onChange(of: focusedField) { _, newFocus in
                    handleFocusChange(newFocus: newFocus)
                }
                .onChange(of: text) { _, newValue in
                    formatWhileTyping(newValue)
                }
        }
    }
}

private extension TimeMaskedTextField {
    
    private func handleFocusChange(newFocus: Int?) {
        if newFocus != index, !text.isEmpty {
            text = TimeFormatter.completeTimeIfNeeded(for: text)
        }
    }
    
    private func formatWhileTyping(_ input: String) {
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
        
        // Limite para minutos e segundos
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
        
        text = formatted
    }
    
    private func completeTimeIfNeeded() {
        let parts = text.split(separator: ":").map { String($0) }
        
        var hours = parts.count > 0 ? parts[0] : "0"
        var minutes = parts.count > 1 ? parts[1] : "0"
        var seconds = parts.count > 2 ? parts[2] : "0"
        
        hours = String(format: "%02d", Int(hours) ?? 0)
        minutes = String(format: "%02d", Int(minutes) ?? 0)
        seconds = String(format: "%02d", Int(seconds) ?? 0)
        
        text = "\(hours):\(minutes):\(seconds)"
    }
}
