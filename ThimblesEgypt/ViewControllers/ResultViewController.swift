//
//  ResultViewController.swift
//  ThimblesEgypt
//
//  Created by Artem Galiev on 11.09.2023.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var audio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkIsWin()
        settingsMusic(win: GameViewController.isWin)
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
    
    //MARK: - Победная или проигрышная музыка
    
    private func settingsMusic(win: Bool) {
        
        var url = Bundle.main.path(forResource: "music", ofType: "mp3")
        switch win {
        case true:  url = Bundle.main.path(forResource: "winner", ofType: "mp3")
        case false: url = Bundle.main.path(forResource: "loser", ofType: "mp3")
        }
        
        do {
            
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let url = url else {
                return
            }
            
            audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            
            guard let audio = audio else {
                return
            }
            audio.volume = 10
            
            audio.play()
            
        } catch {
            print("error in music")
        }
    }

}
