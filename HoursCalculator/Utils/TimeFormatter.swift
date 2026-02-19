//
//  TimeFormatter.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

final class TimeFormatter {
    static func completeTimeIfNeeded(for input: String) -> String {
        let parts = input.split(separator: ":").map { String($0) }
        
        var hours = parts.count > 0 ? parts[0] : "0"
        var minutes = parts.count > 1 ? parts[1] : "0"
        var seconds = parts.count > 2 ? parts[2] : "0"
        
        // Garante 2 dígitos para minutos e segundos
        hours = String(format: "%02d", Int(hours) ?? 0)
        minutes = String(format: "%02d", Int(minutes) ?? 0)
        seconds = String(format: "%02d", Int(seconds) ?? 0)
        
       return "\(hours):\(minutes):\(seconds)"
    }
}
