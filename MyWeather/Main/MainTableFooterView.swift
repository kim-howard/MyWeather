//
//  MainTableFooterView.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class MainTableFooterView: UIView {
    
    lazy var sharedAppDelegate: AppDelegate = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("appDelegate Error")
        }
        return appDelegate
    }()

    @IBOutlet weak var celsiusButton: UIButton! {
        didSet {
            celsiusButton.addTarget(self, action: #selector(didTapCelsiusButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var fahrenheitButton: UIButton! {
        didSet {
            fahrenheitButton.addTarget(self, action: #selector(didTapFahrenheitButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var plusButton: UIButton! {
        didSet {
            plusButton.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if sharedAppDelegate.isUserPreferCelsius {
            celsiusButton.setTitleColor(.white, for: .normal)
            fahrenheitButton.setTitleColor(.lightGray, for: .normal)
        } else {
            celsiusButton.setTitleColor(.lightGray, for: .normal)
            fahrenheitButton.setTitleColor(.white, for: .normal)
        }
    }
    
    weak var delegate: MainTableFooterViewDelegate?
    
    @objc func didTapCelsiusButton(_ sender: UIButton) {
        if !sharedAppDelegate.isUserPreferCelsius {
            celsiusButton.setTitleColor(.white, for: .normal)
            fahrenheitButton.setTitleColor(.lightGray, for: .normal)
            sharedAppDelegate.isUserPreferCelsius = true
            delegate?.didTapTemparatureDegreeButton()
        }
    }
    
    @objc func didTapFahrenheitButton(_ sender: UIButton) {
        if sharedAppDelegate.isUserPreferCelsius {
            fahrenheitButton.setTitleColor(.white, for: .normal)
            celsiusButton.setTitleColor(.lightGray, for: .normal)
            sharedAppDelegate.isUserPreferCelsius = false
            delegate?.didTapTemparatureDegreeButton()
        }
    }

    @objc func didTapPlusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton()
    }
}
