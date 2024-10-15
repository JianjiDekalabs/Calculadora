import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            
            VStack(alignment: .trailing) {
                
                // Texto estático de "0"
                TextField("0", text: $viewModel.display)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.gray)
                    .font(.system(size: 30, weight: .light))
                
                // TextField para mostrar los resultados
                TextField("0", text: $viewModel.result)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 90, weight: .light))
                    .disabled(true) // Evitar que el usuario edite directamente
                
                // Filas de botones de la calculadora
                HStack {
                    Buttons(valor: "AC", viewModel: viewModel)
                    Buttons(valor: "%", viewModel: viewModel)
                    Buttons(valor: "%", viewModel: viewModel)
                    Buttons(valor: "/", viewModel: viewModel)
                        .foregroundStyle(.orange)
                }.foregroundStyle(.gray)
                
                HStack {
                    Buttons(valor: "7", viewModel: viewModel)
                    Buttons(valor: "8", viewModel: viewModel)
                    Buttons(valor: "9", viewModel: viewModel)
                    Buttons(valor: "*", viewModel: viewModel)
                        .foregroundStyle(.orange)
                }.foregroundStyle(Color(hex: "#333333"))
                
                HStack {
                    Buttons(valor: "4", viewModel: viewModel)
                    Buttons(valor: "5", viewModel: viewModel)
                    Buttons(valor: "6", viewModel: viewModel)
                    Buttons(valor: "-", viewModel: viewModel)
                        .foregroundStyle(.orange)
                }.foregroundStyle(Color(hex: "#333333"))
                
                HStack {
                    Buttons(valor: "1", viewModel: viewModel)
                    Buttons(valor: "2", viewModel: viewModel)
                    Buttons(valor: "3", viewModel: viewModel)
                    Buttons(valor: "+", viewModel: viewModel)
                        .foregroundStyle(.orange)
                }.foregroundStyle(Color(hex: "#333333"))
                
                HStack {
                    Buttons(valor: "0", viewModel: viewModel)
                    Buttons(valor: "0", viewModel: viewModel)
                    Buttons(valor: ".", viewModel: viewModel)
                    Buttons(valor: "=", viewModel: viewModel)
                        .foregroundStyle(.orange)
                }.foregroundStyle(Color(hex: "#333333"))
            }
        }
    }
}

// Estructura del botón
struct Buttons: View {
    var valor: String
    @ObservedObject var viewModel: ViewModel // Usar el mismo ViewModel que la vista principal
    
    var body: some View {
        ZStack {
            Circle()
            Button (action: {
                // Llamar a las funciones del ViewModel
                if valor == "AC" {
                    viewModel.clear()
                } else {
                    viewModel.receiveInput(valor)
                }
            }, label: {
                Text(valor)
                    .foregroundStyle(.white)
            })
        }
    }
}

// Función para convertir de hex a Color
extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255
        let green = Double((rgb & 0x00FF00) >> 8) / 255
        let blue = Double(rgb & 0x0000FF) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
}

#Preview {
    ContentView()
}
