# Calculadora de Horas

Uma aplicação iOS simples e intuitiva para cálculos de tempo, permitindo somar e subtrair horas, minutos e segundos, além de calcular tempo de treino.

## Funcionalidades

### 📊 Calculadora de Horas
- ✅ **Adicionar múltiplos tempos**: Adicione quantas linhas de tempo precisar
- ✅ **Somar tempos**: Calcule a soma total de todos os tempos inseridos
- ✅ **Subtrair tempos**: Subtraia tempos em sequência
- ✅ **Formatação automática**: Os tempos são formatados automaticamente no padrão HH:mm:ss
- ✅ **Validação em tempo real**: Minutos e segundos são limitados a 59
- ✅ **Guardar resultado**: Salve o resultado e use como primeira entrada para novos cálculos
- ✅ **Limpar dados**: Resete todos os campos com um clique

### 🏋️ Resumo de Treino
- ✅ **Cálculo de tempo de treino**: Insira horário de entrada e saída
- ✅ **Registrar pausas**: Adicione quantas pausas de cardio forem necessárias
- ✅ **Tempo líquido**: Desconta o tempo de pausa do tempo total de treino
- ✅ **Gerenciar pausas**: Adicione ou remova pausas facilmente
- ✅ **Resultado automático**: Visualize o tempo restante de treino

## Requisitos

- iOS 18.0 ou superior
- Xcode 16.4+
- Swift 5.0+

## Menu Principal

Ao abrir a aplicação, você se depara com um menu principal com duas opções:

- **Calculadora de Horas**: Realize somas e subtrações de tempos simples
- **Resumo de Treino**: Calcule o tempo efetivo de treino considerando pausas

## Arquitetura

O projeto segue o padrão **MVVM** (Model-View-ViewModel) com modularização por features:

### Estrutura de Pastas

```
HoursCalculator/
├── HoursCalculatorApp.swift          # Ponto de entrada da aplicação
├── MainView.swift                    # Menu principal
├── Calculator/                       # Feature: Calculadora de Horas
│   ├── View/
│   │   └── HoursCalculatorView.swift
│   └── ViewModel/
│       └── HoursCalculatorViewModel.swift
├── Interval/                         # Feature: Resumo de Treino
│   ├── Model/
│   ├── View/
│   │   └── TimeCalculatorView.swift
│   └── ViewModel/
│       └── TimeCalculatorViewModel.swift
├── Commons/                          # Componentes reutilizáveis
├── Utils/                            # Utilitários e extensões
└── Assets.xcassets/                  # Recursos visuais
```

### Responsabilidades

- **View**: Apresentação de UI, gestão de foco e inputs do usuário
- **ViewModel**: Cálculos, formatação de tempo e gerenciamento de estado
- **Model**: Enums para operações (add/subtract)

## Como Usar

### 🧮 Calculadora de Horas

1. **Inserir tempos**: Digite o tempo no formato HH:mm:ss (ou parcialmente, será completado ao sair do campo)
2. **Adicionar linhas**: Clique no botão "+" para adicionar mais campos de tempo
3. **Somar**: Clique em "Somar" para calcular a soma de todos os tempos
4. **Subtrair**: Clique em "Subtrair" para subtrair sequencialmente (primeiro - segundo - terceiro, etc)
5. **Guardar**: Use o resultado anterior como primeira entrada clicando em "Guardar"
6. **Limpar**: Resete todos os campos com o botão vermelho "Limpar"

**Exemplo:**
```
Tempo 1: 02:30:45
Tempo 2: 01:15:30
Tempo 3: 00:45:00

Somar → Resultado: 04:31:15
```

### 🏋️ Resumo de Treino

1. **Horário de entrada**: Selecione a hora que você começou o treino
2. **Horário de saída**: Selecione a hora que você terminou o treino
3. **Adicionar pausas**: Clique em "Adicionar" para registrar pausas de cardio
4. **Inserir duração**: Digite o tempo de cada pausa no formato HH:mm:ss
5. **Remover pausa**: Use o ícone de lixo para remover uma pausa
6. **Calcular**: Clique em "Calcular" para obter o tempo restante de treino

**Exemplo:**
```
Entrada: 07:00
Saída: 08:30
Cardios (pausas): 
  - 00:10:00
  - 00:08:30

Tempo total: 1:30
Tempo de pausa: 0:18:30
Tempo restante: 1:11:30
```

## Testes

Os testes unitários estão em `HoursCalculatorTests/`. Execute com:
```bash
Cmd + U
```

## Desenvolvimento

### Pré-requisitos
- Xcode 16.4 ou superior
- Swift 5.0+

### Estrutura do Código

#### HoursCalculatorViewModel
Responsável por:
- `formatWhileTyping()` - Formata entrada enquanto o usuário digita
- `completeTimeIfNeeded()` - Completa o formato ao sair do campo
- `calculateTime()` - Realiza cálculos de soma/subtração

#### HoursCalculatorView
Responsável por:
- Renderizar a interface
- Gerenciar foco dos TextFields
- Disparar ações do ViewModel

## Autor

Enzo Soares - 2026
