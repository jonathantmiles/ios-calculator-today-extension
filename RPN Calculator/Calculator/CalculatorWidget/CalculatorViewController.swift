//
//  CalculatorViewController.swift
//  Calculator
//

import UIKit
import RPN
import NotificationCenter

class CalculatorViewController: UIViewController, UITextFieldDelegate, NCWidgetProviding {
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.isUserInteractionEnabled = true
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        textField.addGestureRecognizer(gestureRecognizer)
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize // same as maximum allowed size in argument
            //rateHistoryView.isHidden = true
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 450)
            //rateHistoryView.isHidden = false
        }
    }
    
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - UIGestureRecognizer
    
    @objc func handleLongPressGesture(recognizer: UIGestureRecognizer) {
        
        if let recognizerView = recognizer.view {
            let recognizerSuperView = UIStackView(arrangedSubviews: [recognizerView]) 
            let menuController = UIMenuController.shared
            menuController.setTargetRect(recognizerView.frame, in: recognizerSuperView)
            menuController.setMenuVisible(true, animated: true)
            recognizerView.becomeFirstResponder()
        }
    }
    
    // MARK: - Methods from standard Calculator View
    
	@IBOutlet var textField: CopyableView!
	
	private let numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.allowsFloats = true
		formatter.maximumIntegerDigits = 20
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 20
		return formatter
	}()
	
	private var calculator = Calculator() {
		didSet {
			if let value = calculator.topValue {
				textField.text = numberFormatter.string(from: value as NSNumber)
			} else {
				textField.text = ""
			}
		}
	}
	
	private var digitAccumulator = DigitAccumulator() {
		didSet {
			if let value = digitAccumulator.value() {
				textField.text = numberFormatter.string(from: value as NSNumber)
			} else {
				textField.text = ""
			}
		}
	}
	
	@IBAction func numberButtonTapped(_ sender: UIButton) {
		try? digitAccumulator.add(digit: .number(sender.tag))
	}
	
	@IBAction func decimalButtonTapped(_ sender: UIButton) {
		try? digitAccumulator.add(digit: .decimalPoint)
	}
	
	@IBAction func returnButtonTapped(_ sender: UIButton) {
		if let value = digitAccumulator.value() {
			calculator.push(number: value)
		}
		digitAccumulator.clear()
	}
	
	@IBAction func divideButtonTapped(_ sender: UIButton) {
		returnButtonTapped(sender)
		calculator.push(operator: .divide)
	}
	
	@IBAction func multiplyButtonTapped(_ sender: UIButton) {
		returnButtonTapped(sender)
		calculator.push(operator: .multiply)
	}
	
	@IBAction func subtractButtonTapped(_ sender: UIButton) {
		returnButtonTapped(sender)
		calculator.push(operator: .subtract)
	}
	
	@IBAction func plusButtonTapped(_ sender: UIButton) {
		returnButtonTapped(sender)
		calculator.push(operator: .add)
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		calculator.clear()
		digitAccumulator.clear()
		return true
	}
}
