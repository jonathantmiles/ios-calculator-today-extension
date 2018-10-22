//
//  CopyableView.swift
//  CalculatorWidget
//
//  Created by Jonathan T. Miles on 10/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class CopyableView: UITextField {

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(NSObject.copy as (NSObject) -> () -> Any))
    }
    
    // MARK: - UIResponderStandardEditActions
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
}
