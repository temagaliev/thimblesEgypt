//
//  GameViewController.swift
//  ThimblesEgypt
//
//  Created by Artem Galiev on 10.09.2023.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var winBoxButton: UIButton!
    @IBOutlet weak var losersBoxNumberOneButton: UIButton!
    @IBOutlet weak var losersBoxNumberTwoButton: UIButton!

    @IBOutlet weak var winBoxConstraint: NSLayoutConstraint!
    @IBOutlet weak var loserBoxNumberOneConstraint: NSLayoutConstraint!
    @IBOutlet weak var loserBoxNumberTwoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var soundOffButton: UIButton!
    
    let winCoinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: NameImage.coin.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let losersScorpOneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: NameImage.scorpion.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let losersScorpTwoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: NameImage.scorpion.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var audio: AVAudioPlayer?
    static var isMusicOn: Bool = true
    
    static var isWin: Bool = false
    var isGame: Bool = true
    
    let topPositionForConstraint: CGFloat = -130
    let centralPositionForConstraint: CGFloat = 0
    let bottomPositionForConstraint: CGFloat = 130
    
    var levelDifficulty: DifficultyLevel = ViewController.currentDifLevel
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialElementSettings()
        startGame()
        settingsMusic()
        blockUsersInteractive(active: false)
        checkStatusMusicForButtonImage()
    }

    
    //MARK: - Обработка нажатия на ящики
    @IBAction func loserBoxNumberOneAction(_ sender: Any) {
        GameViewController.isWin = false
        offMusic()
    }
    
    @IBAction func winBoxAction(_ sender: Any) {
        GameViewController.isWin = true
        offMusic()
    }
    
    @IBAction func loserBoxNumberTwoAction(_ sender: Any) {
        GameViewController.isWin = false
        offMusic()
    }
    
    //MARK: - Вкл/выкл музыка
    @IBAction func soundOffAction(_ sender: Any) {
        GameViewController.isMusicOn = !GameViewController.isMusicOn
        switch GameViewController.isMusicOn {
        case true: audio?.play()
        case false: audio?.pause()
        }
        checkStatusMusicForButtonImage()
    }
    
    //MARK: - Назад в меню
    @IBAction func backMenuAction(_ sender: UIButton) {
        offMusic()
    }
    
    //MARK: - Запуск игры
    private func startGame() {
        
        //Подготовка к началу, скрываются все эелементы
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.winBoxButton.setImage(UIImage(named: NameImage.boxClosed.rawValue), for: .normal)
            self.losersBoxNumberOneButton.setImage(UIImage(named: NameImage.boxClosed.rawValue), for: .normal)
            self.losersBoxNumberTwoButton.setImage(UIImage(named: NameImage.boxClosed.rawValue), for: .normal)
            
            self.winCoinImage.isHidden = true
            self.losersScorpOneImage.isHidden = true
            self.losersScorpTwoImage.isHidden = true
            
        })
        
        //Определение количества циклов вращения ящиков
        let randomValue = Int.random(in: 3...6)
        var timeDelay: Int = 700
        switch levelDifficulty {
        case .easy: timeDelay = 600
        case .medium: timeDelay = 400
        case .hard: timeDelay = 400
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            switch randomValue {
            case 3:
                self.rotationBox(timeDelay: timeDelay)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(1000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                    self.blockUsersInteractive(active: true)
                })
            case 4:
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(1000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(3000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                    self.blockUsersInteractive(active: true)
                })
            case 5:
                self.rotationBox(timeDelay: timeDelay)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(1000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(3000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(4000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                    self.blockUsersInteractive(active: true)
                })

            case 6:
                self.rotationBox(timeDelay: timeDelay)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(1000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(3000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(4000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(5000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                    self.blockUsersInteractive(active: true)
                })

            default:
                self.rotationBox(timeDelay: timeDelay)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(1000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2000 * self.levelDifficulty.rawValue)), execute: {
                    self.rotationBox(timeDelay: timeDelay)
                    self.blockUsersInteractive(active: true)

                })
            }
        })
    }
    
    //MARK: - Перемещение ящиков один цикл
    private func rotationBox(timeDelay: Int) {
        //Проверка в какой позиции находится выигрышный ящик
            switch self.winBoxConstraint.constant {
            case -130:
                if loserBoxNumberOneConstraint.constant == 0 {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationTopToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationCenterToTopElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                    })

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToBottomElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })
                } else {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationTopToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationCenterToTopElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToBottomElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                    })
                    
                }
                
            case 0:
                if loserBoxNumberOneConstraint.constant == -130 {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationTopToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                    })

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToBottomElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })
                    
                } else if loserBoxNumberOneConstraint.constant == 130 {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationTopToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToBottomElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                    })

                }
            case 130:
                if loserBoxNumberOneConstraint.constant == 0 {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationBottomToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationCenterToBottomElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)

                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationTopToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })
                } else {

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0), execute: {
                        self.animationBottomToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationCenterToBottomElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint, level: self.levelDifficulty)
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeDelay), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint, level: self.levelDifficulty)
                        self.animationTopToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint, level: self.levelDifficulty)
                    })
                    
                }
            default: print("error in rotation")
            
            
        }
    }
    
    //Установление констрейнтов
    private func initialElementSettings () {

        self.winBoxButton.addSubview(winCoinImage)
        self.losersBoxNumberOneButton.addSubview(losersScorpOneImage)
        self.losersBoxNumberTwoButton.addSubview(losersScorpTwoImage)
        
        createImageInButtonConstrains(image: winCoinImage, button: winBoxButton)
        createImageInButtonConstrains(image: losersScorpOneImage, button: losersBoxNumberOneButton)
        createImageInButtonConstrains(image: losersScorpTwoImage, button: losersBoxNumberTwoButton)
    }
    
    private func blockUsersInteractive(active: Bool) {
        winBoxButton.isUserInteractionEnabled = active
        losersBoxNumberOneButton.isUserInteractionEnabled = active
        losersBoxNumberTwoButton.isUserInteractionEnabled = active
    }
    
    
    private func createImageInButtonConstrains(image: UIImageView, button: UIButton) {
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -20).isActive = true
    }
    
    //MARK: - Настройка музыки
    private func settingsMusic() {
        let url = Bundle.main.path(forResource: "music", ofType: "mp3")
        
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
            audio.volume = 20
            
            if GameViewController.isMusicOn == true {
                audio.play()
            }
        } catch {
            print("error in music")
        }
    }
    
    private func offMusic() {
        if audio?.isPlaying == true {
            audio?.stop()
        }
    }
    
    private func checkStatusMusicForButtonImage() {
        switch GameViewController.isMusicOn {
        case true: soundOffButton.setImage(UIImage(named: NameImage.soundOn.rawValue), for: .normal)
        case false: soundOffButton.setImage(UIImage(named: NameImage.soundOff.rawValue), for: .normal)
        }
    }


    //MARK: - Анимация перемещения
    //центр -> вверх
    private func animationCenterToTopElement(button: UIButton, constraint: NSLayoutConstraint, level: DifficultyLevel) {
        let points = [CGPoint(x: view.center.x, y: view.center.y),
                      CGPoint(x: view.center.x - 50, y: view.center.y - 20),
                      CGPoint(x: view.center.x - 80, y: view.center.y - 40),
                      CGPoint(x: view.center.x - 100, y: view.center.y - 60),
                      CGPoint(x: view.center.x - 80, y: view.center.y - 80),
                      CGPoint(x: view.center.x - 50, y: view.center.y - 100),
                      CGPoint(x: view.center.x, y: view.center.y - 130)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points
        
        switch levelDifficulty {
        case .easy:
            animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
            animation.duration = 0.7
        case .medium:
            animation.keyTimes = [0.0, 0.07, 0.14, 0.21, 0.28, 0.35, 0.42, 0.49]
            animation.duration = 0.49
        case .hard:
            animation.keyTimes = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35]
            animation.duration = 0.35
        }
        

        button.layer.add(animation, forKey: nil)
        
        constraint.constant = topPositionForConstraint
        
    }
    
    //вверх -> центр
    private func animationTopToCenterElement(button: UIButton, constraint: NSLayoutConstraint, level: DifficultyLevel) {
        let points = [CGPoint(x: view.center.x, y: view.center.y - 130),
                      CGPoint(x: view.center.x + 50, y: view.center.y - 100),
                      CGPoint(x: view.center.x + 80, y: view.center.y - 80),
                      CGPoint(x: view.center.x + 100, y: view.center.y - 60),
                      CGPoint(x: view.center.x + 80, y: view.center.y - 40),
                      CGPoint(x: view.center.x + 50, y: view.center.y - 20),
                      CGPoint(x: view.center.x, y: view.center.y)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points

        switch levelDifficulty {
        case .easy:
            animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
            animation.duration = 0.7
        case .medium:
            animation.keyTimes = [0.0, 0.07, 0.14, 0.21, 0.28, 0.35, 0.42, 0.49]
            animation.duration = 0.49
        case .hard:
            animation.keyTimes = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35]
            animation.duration = 0.35
        }
        
        button.layer.add(animation, forKey: nil)
        
        constraint.constant = centralPositionForConstraint
    }
    
    //центр -> вниз
    private func animationCenterToBottomElement(button: UIButton, constraint: NSLayoutConstraint, level: DifficultyLevel) {
        let points = [CGPoint(x: view.center.x, y: view.center.y),
                      CGPoint(x: view.center.x + 50, y: view.center.y + 20),
                      CGPoint(x: view.center.x + 80, y: view.center.y + 40),
                      CGPoint(x: view.center.x + 100, y: view.center.y + 60),
                      CGPoint(x: view.center.x + 80, y: view.center.y + 80),
                      CGPoint(x: view.center.x + 50, y: view.center.y + 100),
                      CGPoint(x: view.center.x, y: view.center.y + 130)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points

        switch levelDifficulty {
        case .easy:
            animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
            animation.duration = 0.7
        case .medium:
            animation.keyTimes = [0.0, 0.07, 0.14, 0.21, 0.28, 0.35, 0.42, 0.49]
            animation.duration = 0.49
        case .hard:
            animation.keyTimes = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35]
            animation.duration = 0.35
        }

        button.layer.add(animation, forKey: nil)
        
        constraint.constant = bottomPositionForConstraint
        
    }
    
    //вниз -> центр
    private func animationBottomToCenterElement(button: UIButton, constraint: NSLayoutConstraint, level: DifficultyLevel) {
        let points = [CGPoint(x: view.center.x, y: view.center.y + 130),
                      CGPoint(x: view.center.x - 50, y: view.center.y + 100),
                      CGPoint(x: view.center.x - 80, y: view.center.y + 80),
                      CGPoint(x: view.center.x - 100, y: view.center.y + 60),
                      CGPoint(x: view.center.x - 80, y: view.center.y + 40),
                      CGPoint(x: view.center.x - 50, y: view.center.y + 20),
                      CGPoint(x: view.center.x, y: view.center.y)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points

        switch levelDifficulty {
        case .easy:
            animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
            animation.duration = 0.7
        case .medium:
            animation.keyTimes = [0.0, 0.07, 0.14, 0.21, 0.28, 0.35, 0.42, 0.49]
            animation.duration = 0.49
        case .hard:
            animation.keyTimes = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35]
            animation.duration = 0.35
        }
        
        button.layer.add(animation, forKey: nil)
        
        constraint.constant = centralPositionForConstraint
    }
}


