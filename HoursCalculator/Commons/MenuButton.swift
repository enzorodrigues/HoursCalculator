//
//  MenuButton.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

import SwiftUI

struct MenuButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}
