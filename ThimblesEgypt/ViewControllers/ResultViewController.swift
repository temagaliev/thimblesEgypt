//
//  ResultViewController.swift
//  ThimblesEgypt
//
//  Created by Artem Galiev on 11.09.2023.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkIsWin()
    }
    
    //MARK: - Проверка статуса isWin
    private func checkIsWin() {
        switch GameViewController.isWin {
        case true:
            backgroundImage.image = UIImage(named: NameImage.newBg.rawValue)
            imageView.image = UIImage(named: NameImage.winView.rawValue)
        case false:
            backgroundImage.image = UIImage(named: NameImage.bg.rawValue)
            imageView.image = UIImage(named: NameImage.loserView.rawValue)
        }
    }

}
