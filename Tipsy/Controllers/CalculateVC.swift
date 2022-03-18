import UIKit

class CalculateVC: UIViewController {
    
    var calculator = Calculator()
    
    @IBOutlet weak var totalSumTextField: UITextField!
    @IBOutlet weak var splitsLabel: UILabel!
    @IBOutlet weak var totalSumWithTipLabel: UILabel!
    
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    
    
    @IBAction func tipPercentageChanged(_ sender: UIButton) {
        
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        
        sender.isSelected = true
        
        if totalSumTextField.hasText {
            
            let totalSum = calculator.getTotalSum(from: totalSumTextField.text)
            
            let tipPercentage = calculator.getTipPercentage(from: sender.currentTitle)
            
            let totalSumWithTip = calculator.getBillTotal(including: tipPercentage, from: totalSum)
            
            totalSumWithTipLabel.text = String(format: "%0.2f", totalSumWithTip)
        }
    }
    
    
    @IBAction func splitChanged(_ sender: UIStepper) {
        splitsLabel.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func calcButtonTapped(_ sender: UIButton) {
        
        if totalSumTextField.hasText {
            
            let totalSum = calculator.getTotalSum(from: totalSumTextField.text)
            
            let percentageButtons: Array<UIButton> = [zeroPercentButton, tenPercentButton, twentyPercentButton]
            for button in percentageButtons{
                if button.isSelected {
                    
                    let percentage = calculator.getTipPercentage(from: button.currentTitle)
                    
                    guard let splitsAsString = splitsLabel.text else {return}
                    guard let splits = Int(splitsAsString) else {return}
                    
                    calculator.calculateBillPerPerson(totalSum: totalSum, tipPercentage: percentage, splits: splits)
                    
                    performSegue(withIdentifier: "goToResultVC", sender: self)
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResultVC" {
            
            guard let destination = segue.destination as? ResultVC else {return}
            
            let totalPerPerson = calculator.bill.totalPerPerson
            destination.bill.totalPerPerson = totalPerPerson
            
            let splits = calculator.bill.splits
            destination.bill.splits = splits
            
            let tip = calculator.bill.tip
            destination.bill.tip = tip
        }
    }
}
