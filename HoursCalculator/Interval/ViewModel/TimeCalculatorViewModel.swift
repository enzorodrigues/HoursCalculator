//
//  TimeCalculatorViewModel.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

import Foundation

class TimeCalculatorViewModel: ObservableObject {
    
    @Published var entryTime: Date = Date()
    @Published var exitTime: Date = Date()
    
    @Published var breaks: [CardioDurationModel] = []
    
    @Published var result: String = ""
    
    // MARK: - Public
    
    func addBreak() {
        breaks.append(CardioDurationModel())
    }
    
    func removeBreak(at index: Int) {
        breaks.remove(at: index)
    }
    
    func calculate(lastIndexUpdated: Int?) {
        if let index = lastIndexUpdated, breaks[index].duration.count < 6 {
            breaks[index].duration = TimeFormatter.completeTimeIfNeeded(for: breaks[index].duration)
        }

        var totalWorked = exitTime.timeIntervalSince(entryTime)
        
        // suporte virada de dia
        if totalWorked < 0 {
            totalWorked += 24 * 3600
        }
        
        let totalCardio = breaks.reduce(0) { partial, item in
            partial + timeInterval(from: item.duration)
        }
        
        let final = max(0, totalWorked - totalCardio)
        result = format(interval: final)
    }
    
    // MARK: - Helpers
    
    private func timeInterval(from string: String) -> TimeInterval {
        let parts = string.split(separator: ":").map { Int($0) ?? 0 }
        
        guard parts.count == 3 else { return 0 }
        
        let hours = parts[0]
        let minutes = parts[1]
        let seconds = parts[2]
        
        return TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }
    
    private func format(interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


