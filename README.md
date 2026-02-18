# Calculadora de Horas

Uma aplicação iOS simples e intuitiva para cálculos de tempo, permitindo somar e subtrair horas, minutos e segundos.

## Funcionalidades

- ✅ **Adicionar múltiplos tempos**: Adicione quantas linhas de tempo precisar
- ✅ **Somar tempos**: Calcule a soma total de todos os tempos inseridos
- ✅ **Subtrair tempos**: Subtraia tempos em sequência
- ✅ **Formatação automática**: Os tempos são formatados automaticamente no padrão HH:mm:ss
- ✅ **Validação em tempo real**: Minutos e segundos são limitados a 59
- ✅ **Guardar resultado**: Salve o resultado e use como primeira entrada para novos cálculos
- ✅ **Limpar dados**: Resete todos os campos com um clique

## Requisitos

- iOS 18.0 ou superior
- Xcode 16.4+
- Swift 5.0+

## Arquitetura

O projeto segue o padrão **MVVM** (Model-View-ViewModel):

### Estrutura de Pastas

```
HoursCalculator/
├── HoursCalculatorApp.swift          # Ponto de entrada da aplicação
├── HoursCalculatorView.swift         # View principal
├── ViewModel/
│   └── HoursCalculatorViewModel.swift # Lógica de negócio
└── Assets.xcassets/                  # Recursos visuais (ícones, cores)
```

### Responsabilidades

- **View**: Apresentação de UI, gestão de foco e inputs do usuário
- **ViewModel**: Cálculos, formatação de tempo e gerenciamento de estado
- **Model**: Enums para operações (add/subtract)

## Como Usar

1. **Inserir tempos**: Digite o tempo no formato HH:mm:ss (ou parcialmente, será completado ao sair do campo)
2. **Adicionar linhas**: Clique no botão "+" para adicionar mais campos de tempo
3. **Somar**: Clique em "Somar" para calcular a soma de todos os tempos
4. **Subtrair**: Clique em "Subtrair" para subtrair sequencialmente (primeiro - segundo - terceiro, etc)
5. **Guardar**: Use o resultado anterior como primeira entrada clicando em "Guardar"
6. **Limpar**: Resete todos os campos com o botão vermelho "Limpar"

## Exemplo de Uso

```
Tempo 1: 02:30:45
Tempo 2: 01:15:30
Tempo 3: 00:45:00

Somar → Resultado: 04:31:15
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
