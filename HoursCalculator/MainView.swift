//
//  MainView.swift
//  HoursCalculator
//
//  Created by Enzo Soares on 18/02/26.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Spacer()
                
                Text("Menu Principal")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                // Botão 1
                NavigationLink {
                    HoursCalculatorView()
                } label: {
                    MenuButton(title: "Calculadora de Horas")
                }
                
                // Botão 2
                NavigationLink {
                    TimeCalculatorView()
                } label: {
                    MenuButton(title: "Resumo de Treino")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

