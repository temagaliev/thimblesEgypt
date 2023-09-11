//
//  ViewController.swift
//  ThimblesEgypt
//
//  Created by Artem Galiev on 10.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Политика конфиденциальности
    @IBAction func privacyPolicyButtonAction(_ sender: UIButton) {
        let vc = PrivacyPolicyViewController()
        present(vc, animated: true)
    }
    
}

