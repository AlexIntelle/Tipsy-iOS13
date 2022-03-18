import UIKit

class ResultVC: UIViewController {
    
    var bill = Bill(tip: 0, splits: 0, totalPerPerson: 0.0)
    
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPerPersonLabel.text = String(format: "%0.2f", bill.totalPerPerson)
        detailsLabel.text = "Split between \(bill.splits) people, with \(bill.tip)% tip."
    }
    
    @IBAction func recalcTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
