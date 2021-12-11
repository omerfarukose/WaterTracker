//
//  ViewController.swift
//  Water Tracker
//
//  Created by Ömer Faruk KÖSE on 11.12.2021.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var waterLevelConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Properties
    let waterStore = DataStore()
    let targetAmount = 2700.0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(0, forKey: "currentAmount")
        
        updateAppereance()
    }
    
    func updateWaterLevel(amount: Double) {
        let screenHeight = Double(view.frame.size.height)
        let ratio = amount / targetAmount
        let calculatedHeight = screenHeight * ratio
        
        print("Calculated Height :\(calculatedHeight)")
        
        waterLevelConstraint.constant = CGFloat(calculatedHeight)
        
        UIViewPropertyAnimator.init(duration: 0.5, dampingRatio: 0.75) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func updateLabels(amount: Double) {
        let amountToTarget = (targetAmount - amount) / 1000
        
        if amount < targetAmount {
            let subtitleText = String(format: "Bugünkü su ihtiyacını karşılamak için \n%g litre daha su içmelisin.", amountToTarget)
            subtitleLabel.text = subtitleText
            
            if amount == 0 {
                titleLabel.text = "Merhaba! \nBugün su içtin mi?"
            } else {
                titleLabel.text = "Tebrikler! \nDoğru yoldasın."
            }
        } else {
            titleLabel.text = "Muhteşem! \nKendine iyi baktın."
            subtitleLabel.text = "Bugün vücüdun için gereken su miktarının tamamını karşıladın."
        }
    }
    
    func updateAppereance() {
        let currentWaterAmount = waterStore.getCurrentAmount()
        
        updateLabels(amount: currentWaterAmount)
        updateWaterLevel(amount: currentWaterAmount)
    }
    
    @IBAction func addWaterButtonTapped(_ sender: UIButton) {
        var currentAmount = waterStore.getCurrentAmount()
        
        var currentDay = waterStore.getLatestUpdateDay()
        
        var waterAmount = 0.0
        
        switch sender.tag {
        case 0:
            waterAmount = 200
        case 1:
            waterAmount = 500
        case 2:
            waterAmount = 800
        default:
            break
        }
        
        waterStore.addWater(amount: waterAmount)
        updateAppereance()
    }
}

