//
//  Model.swift
//  Calculadora
//
//  Created by Jianji Zhong Huang on 15/10/24.
//

import Foundation

struct Model {
    var pileOfNumbers: [Double] = []
    var pileOfOperators: [Character] = []
    
    
    mutating func calculate() {
        let operantionSimbol = pileOfOperators.removeLast()
        let operation1 = pileOfNumbers.removeLast()
        let operation2 = pileOfNumbers.removeLast()
        
        switch operantionSimbol {
        case "+":
            pileOfNumbers.append(operation1 + operation2)
        case "-":
            pileOfNumbers.append(operation1 - operation2)
        case "*":
            pileOfNumbers.append(operation1 * operation2)
        case "/":
            pileOfNumbers.append(operation1 / operation2)
            default :
            break
        }
    }
    
    mutating func evaluateExpresion(string: String) -> Double{
        
        var aux: Int = 0
        var num:Double = 0
        var thereIsNumber = false
        
        while aux < string.count {
            let currentChar = string[string.index(string.startIndex, offsetBy: aux)]
            
            if let digit = Double(String(currentChar)) {
                
                num = num * 10 + digit
                thereIsNumber = true
            } else {
                if thereIsNumber {
                    pileOfNumbers.append(num)
                    thereIsNumber = false
                    num = 0
                }
                
                if currentChar == "+" || currentChar == "-" {
                    while !pileOfOperators.isEmpty && (pileOfOperators.last == "=" || pileOfOperators.last == "/") {
                        calculate()
                    }
                    pileOfOperators.append(currentChar)
                } else if currentChar == "*" || currentChar == "/" {
                     pileOfOperators.append(currentChar)
                }
            }
            aux += 1
        }
        
        if thereIsNumber {
            pileOfNumbers.append(num)
        }
        
        while !pileOfOperators.isEmpty {
            calculate()
        }
        
        return pileOfNumbers.last!
        
    }
    
}
