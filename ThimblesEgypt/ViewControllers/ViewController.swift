//
//  ViewController.swift
//  ThimblesEgypt
//
//  Created by Artem Galiev on 10.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var difficultyButton: UIButton!
    
    static var currentDifLevel: DifficultyLevel = .medium
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsImageLevel()

    }
    
    //MARK: - Политика конфиденциальности
    @IBAction func privacyPolicyButtonAction(_ sender: UIButton) {
        let vc = PrivacyPolicyViewController()
        present(vc, animated: true)
    }
    
    //MARK: - Выбор уровня сложности
    @IBAction func leftAction(_ sender: Any) {
        switch ViewController.currentDifLevel {
        case .easy:
            leftButton.isUserInteractionEnabled = false
            rightButton.isUserInteractionEnabled = true
        case .medium:
            ViewController.currentDifLevel = .easy
            leftButton.isUserInteractionEnabled = false
            settingsImageLevel()
        case .hard:
            ViewController.currentDifLevel = .medium
            rightButton.isUserInteractionEnabled = true
            settingsImageLevel()
        }
    }
    
    @IBAction func rightAction(_ sender: Any) {
        switch ViewController.currentDifLevel {
        case .easy:
            ViewController.currentDifLevel = .medium
            leftButton.isUserInteractionEnabled = true
            settingsImageLevel()
        case .medium:
            ViewController.currentDifLevel = .hard
            rightButton.isUserInteractionEnabled = false
            settingsImageLevel()
        case .hard:
            leftButton.isUserInteractionEnabled = true
            rightButton.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Смена картинки
    private func settingsImageLevel() {
        switch ViewController.currentDifLevel {
        case .easy: difficultyButton.setImage(UIImage(named: NameImage.easy.rawValue), for: .normal)
        case .medium: difficultyButton.setImage(UIImage(named: NameImage.medium.rawValue), for: .normal)
        case .hard: difficultyButton.setImage(UIImage(named: NameImage.hard.rawValue), for: .normal)
        }
    }
    
}

