//
//  MainTableFooterView.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class MainTableFooterView: UIView {

    @IBOutlet weak var celsiusButton: UIButton!
    @IBOutlet weak var fahrenheitButton: UIButton!
    @IBOutlet weak var plusButton: UIButton! {
        didSet {
            plusButton.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
        }
    }
    
    weak var delegate: MainTableFooterViewDelegate?

    @objc func didTapPlusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton()
    }
}
