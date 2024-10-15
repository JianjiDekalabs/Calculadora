import Foundation

class ViewModel: ObservableObject {
    
    @Published var display: String = "0"  // Lo que se muestra en la calculadora
    @Published var result: String = "0"
    private var model = Model()
    
    func receiveInput(_ input: String) {
        // Actualiza la visualización en función de la entrada del usuario
        if let _ = Double(input) {
            if display == "0" {
                display = input
            } else {
                display += input
            }
        } else {
            processOperator(input)
        }
    }
    
    private func processOperator(_ op: String) {
        if op == "=" {
            // Procesar la expresión y calcular el resultado
            let result = model.evaluateExpresion(string: display)
            self.result = String(result)
        } else {
            // Si es un operador, agregarlo a la cadena de expresión
            display += op
        }
    }
    
    func clear() {
        // Limpiar la pantalla
        display = "0"
        result = "0"
        model.pileOfNumbers = []
        model.pileOfOperators = []
    }
}
