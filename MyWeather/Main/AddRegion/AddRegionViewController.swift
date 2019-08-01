//
//  AddRegionViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class AddRegionViewController: UIViewController {
    
    @IBOutlet weak var regionSearchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSetachBar()
    }
    
    private func setSetachBar() {
        regionSearchBar.delegate = self
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddRegionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 0.5 초간 반응이 없으면 검색
        print("textDidChange")
    }
    
}

