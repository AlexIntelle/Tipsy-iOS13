import UIKit

struct Calculator {
    
    var bill = Bill(tip: 0, splits: 0, totalPerPerson: 0.0)
    
    
    func getTotalSum (from textField: String? ) -> Double {
        
        var result = 0.0
        
        if let totalSumAsString = textField {
            if let totalSum = Double(totalSumAsString) {
                result = totalSum
            }
        }
        
        return result
    }
    
    
    func getTipPercentage (from buttonText: String?) -> Int {
        
        var result = 0
        
        if var percentsAsString = buttonText {
            
            percentsAsString.removeLast()
            
            if let tipPercantage = Int(percentsAsString) {
                result = tipPercantage
            }
        }
        
        return result
    }
    
    
    func getBillTotal(including tipPercentage: Int, from initialTotal: Double) -> Double {

        let onePercent = initialTotal / 100
        let tipSum = onePercent * Double(tipPercentage)

        return initialTotal + tipSum
    }
    
    
    mutating func calculateBillPerPerson(totalSum: Double, tipPercentage: Int, splits: Int) {
        
        let onePercentOfSum = totalSum / 100
        let tipSum = onePercentOfSum * Double(tipPercentage)
        let totalToPay = totalSum + tipSum
        
        let totalPerPerson = totalToPay / Double(splits)
        
        self.bill = Bill(tip: tipPercentage, splits: splits, totalPerPerson: totalPerPerson)
    }
}

