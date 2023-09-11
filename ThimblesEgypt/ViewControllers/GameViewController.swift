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

    override func viewDidLoad() {
        super.viewDidLoad()
        initialElementSettings()
        startGame()
        settingsMusic()
        blockUsersInteractive(active: false)

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
        offMusic()
        GameViewController.isMusicOn = false
    }
    
    @IBAction func soundOnAction(_ sender: UIButton) {
        if audio?.isPlaying == false {
            GameViewController.isMusicOn = true
            audio?.play()
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            switch randomValue {
            case 3:
                self.rotationBox(timeDelay: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.rotationBox(timeDelay: 0)
                    self.blockUsersInteractive(active: true)
                })
            case 4:
                self.rotationBox(timeDelay: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                    self.rotationBox(timeDelay: 0)
                    self.blockUsersInteractive(active: true)
                })
            case 5:
                self.rotationBox(timeDelay: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8), execute: {
                    self.rotationBox(timeDelay: 0)
                    self.blockUsersInteractive(active: true)
                })

            case 6:
                self.rotationBox(timeDelay: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                    self.rotationBox(timeDelay: 0)
                    self.blockUsersInteractive(active: true)
                })

            default:
                self.rotationBox(timeDelay: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.rotationBox(timeDelay: 0)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.rotationBox(timeDelay: 0)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay ), execute: {
                        self.animationTopToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationCenterToTopElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToBottomElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay), execute: {
                        self.animationTopToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationCenterToTopElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToBottomElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                    })
                    
                }
                
            case 0:
                if loserBoxNumberOneConstraint.constant == -130 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationTopToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToBottomElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                    
                } else if loserBoxNumberOneConstraint.constant == 130 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationTopToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToBottomElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                        self.animationBottomToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                    })
                    
                    
                    
                }
            case 130:
                if loserBoxNumberOneConstraint.constant == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay), execute: {
                        self.animationBottomToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationCenterToBottomElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
                        
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationTopToCenterElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay), execute: {
                        self.animationBottomToCenterElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationCenterToBottomElement(button: self.losersBoxNumberTwoButton, constraint: self.loserBoxNumberTwoConstraint)
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeDelay + 1), execute: {
                        self.animationCenterToTopElement(button: self.winBoxButton, constraint: self.winBoxConstraint)
                        self.animationTopToCenterElement(button: self.losersBoxNumberOneButton, constraint: self.loserBoxNumberOneConstraint)
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
            audio?.pause()
        }
    }


    //MARK: - Анимация перемещения
    //центр -> вверх
    private func animationCenterToTopElement(button: UIButton, constraint: NSLayoutConstraint) {
        let points = [CGPoint(x: view.center.x, y: view.center.y),
                      CGPoint(x: view.center.x - 50, y: view.center.y - 20),
                      CGPoint(x: view.center.x - 80, y: view.center.y - 40),
                      CGPoint(x: view.center.x - 100, y: view.center.y - 60),
                      CGPoint(x: view.center.x - 80, y: view.center.y - 80),
                      CGPoint(x: view.center.x - 50, y: view.center.y - 100),
                      CGPoint(x: view.center.x, y: view.center.y - 130)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points
        animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
        animation.duration = 0.7

        button.layer.add(animation, forKey: nil)
        
        constraint.constant = topPositionForConstraint
        
    }
    
    //вверх -> центр
    private func animationTopToCenterElement(button: UIButton, constraint: NSLayoutConstraint) {
        let points = [CGPoint(x: view.center.x, y: view.center.y - 130),
                      CGPoint(x: view.center.x + 50, y: view.center.y - 100),
                      CGPoint(x: view.center.x + 80, y: view.center.y - 80),
                      CGPoint(x: view.center.x + 100, y: view.center.y - 60),
                      CGPoint(x: view.center.x + 80, y: view.center.y - 40),
                      CGPoint(x: view.center.x + 50, y: view.center.y - 20),
                      CGPoint(x: view.center.x, y: view.center.y)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points
        animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
        animation.duration = 0.7
        
        button.layer.add(animation, forKey: nil)
        
        constraint.constant = centralPositionForConstraint
    }
    
    //центр -> вниз
    private func animationCenterToBottomElement(button: UIButton, constraint: NSLayoutConstraint) {
        let points = [CGPoint(x: view.center.x, y: view.center.y),
                      CGPoint(x: view.center.x + 50, y: view.center.y + 20),
                      CGPoint(x: view.center.x + 80, y: view.center.y + 40),
                      CGPoint(x: view.center.x + 100, y: view.center.y + 60),
                      CGPoint(x: view.center.x + 80, y: view.center.y + 80),
                      CGPoint(x: view.center.x + 50, y: view.center.y + 100),
                      CGPoint(x: view.center.x, y: view.center.y + 130)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points
        animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
        animation.duration = 0.7

        button.layer.add(animation, forKey: nil)
        
        constraint.constant = bottomPositionForConstraint
        
    }
    
    //вниз -> центр
    private func animationBottomToCenterElement(button: UIButton, constraint: NSLayoutConstraint) {
        let points = [CGPoint(x: view.center.x, y: view.center.y + 130),
                      CGPoint(x: view.center.x - 50, y: view.center.y + 100),
                      CGPoint(x: view.center.x - 80, y: view.center.y + 80),
                      CGPoint(x: view.center.x - 100, y: view.center.y + 60),
                      CGPoint(x: view.center.x - 80, y: view.center.y + 40),
                      CGPoint(x: view.center.x - 50, y: view.center.y + 20),
                      CGPoint(x: view.center.x, y: view.center.y)]

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.values = points
        animation.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
        animation.duration = 0.7
        
        button.layer.add(animation, forKey: nil)
        
        constraint.constant = centralPositionForConstraint
    }
}


