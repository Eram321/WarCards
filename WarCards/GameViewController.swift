//
//  GameViewController.swift
//  WarCards
//
//  Created by Eram on 18/03/2018.
//  Copyright © 2018 Eram. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, MessageReadableWithDelegate {
    
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    @IBOutlet weak var roundResultLabel: UILabel!
    @IBOutlet weak var playerRemaningCardsLabel: UILabel!
    @IBOutlet weak var computerRemaningCardsLabel: UILabel!
    
    @IBOutlet weak var gameOverView: UIView!
    
    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var gameModel : GameModel = GameModel()
    
    var imagesSubViews : [UIImageView] = [UIImageView]()
    var lastPlayerPosition : CGPoint = CGPoint()
    var lastComputerPosition : CGPoint = CGPoint()
    
    @IBAction func gameOverAction(_ sender: Any) {
        delegate?.readMessage(message: gameModel.playerScore)
    }
    
    @IBAction func backToMenuAction(_ sender: Any) {
        delegate?.readMessage(message: 0)
    }
    
    func readMessage(message: Int) {}
    
    var delegate: MessageReadable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lastPlayerPosition.x = playerImageView.frame.origin.x
        lastPlayerPosition.y = playerImageView.frame.origin.y + 25
        lastComputerPosition.x = computerImageView.frame.origin.x
        lastComputerPosition.y = computerImageView.frame.origin.y + 25
        
        computerImageView.image = nil
        computerScoreLabel.text = "0"
        playerImageView.image = nil
        playerScoreLabel.text = "0"
        roundResultLabel.text = ""
        playerRemaningCardsLabel.text = "\(gameModel.getPlayerRemaningCards())"
        computerRemaningCardsLabel.text = "\(gameModel.getComputerRemaningCards())"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerDeckClickAction(_ sender: Any) {

        let roundResult = gameModel.startRound()
        if roundResult.result == Result.GameEnd{
            gameEnd()
            return
        }
        
        if gameModel.lastRoundResult == Result.War{
            
            var image = getCurretCardImage(roundResult: roundResult, playerCard: true)
            let playerView = UIImageView(image: image)
            setWarImageView(imageView: playerView, pos: lastPlayerPosition)
            lastPlayerPosition.y += 25;
            
            image = getCurretCardImage(roundResult: roundResult, playerCard: false)
            let computerView = UIImageView(image: image)
            setWarImageView(imageView: computerView, pos: lastComputerPosition)
            lastComputerPosition.y += 25;

        }
        else{
            computerImageView.image = roundResult.computerCard?.image
            playerImageView.image = roundResult.playerCard?.image
            
            resetWarImageViews()
        }
        
        setResultUI(roundResult: roundResult)
        
        UIView.animate(withDuration: 1, animations: {
            self.roundResultLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in
            self.roundResultLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        })
        
        computerScoreLabel.text = "\(gameModel.computerScore)"
        playerScoreLabel.text = "\(gameModel.playerScore)"
        playerRemaningCardsLabel.text = "\(gameModel.getPlayerRemaningCards())"
        computerRemaningCardsLabel.text = "\(gameModel.getComputerRemaningCards())"
    
        gameModel.roundEnd(result: roundResult.result)
    }
    
    func setResultUI(roundResult : RoundResult){
        
        switch roundResult.result {
        case Result.Win:
            roundResultLabel.text = "Round Win"
        case .Lose:
            roundResultLabel.text = "Round Lose"
        case .War:
            roundResultLabel.text = "WAR"
        default:
            roundResultLabel.text = ""
        }
        
    }
    
    func gameEnd(){
        resetWarImageViews()
        gameOverView.isHidden = false
        
        gameResultLabel.text = gameModel.isPlayerWinGame()
        scoreLabel.text = "Score : " + "\(gameModel.playerScore)"
    }
    
    func resetWarImageViews(){
        lastComputerPosition.y = computerImageView.frame.origin.y + 25
        lastPlayerPosition.y = playerImageView.frame.origin.y + 25
        
        for imageView in imagesSubViews{
            imageView.removeFromSuperview()
        }
        imagesSubViews.removeAll()
    }
    
    
    func getCurretCardImage(roundResult : RoundResult, playerCard : Bool) -> UIImage{
        
        if gameModel.isWarPassCard() {
            if playerCard{ return UIImage(named: "CardBackGreen")!} else {return UIImage(named: "CardBackRed")!}
        }else{
            if playerCard{ return (roundResult.playerCard?.image)!} else {return (roundResult.computerCard?.image)!}
        }
    }

    func setWarImageView(imageView : UIImageView, pos : CGPoint){
        
        imageView.frame = CGRect(x: pos.x, y: pos.y, width: 105, height: 142)
        
        view.addSubview(imageView)
        imagesSubViews.append(imageView)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
