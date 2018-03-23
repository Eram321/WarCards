//
//  GameModel.swift
//  WarCards
//
//  Created by Eram on 22/03/2018.
//  Copyright © 2018 Eram. All rights reserved.
//

import Foundation

enum Result {
    case Win
    case Lose
    case War
    case GameEnd
    case None
}

struct RoundResult{
    let playerCard : Card?
    let computerCard : Card?
    var result : Result
    init(playerCard : Card?, computerCard : Card?) {
        self.playerCard = playerCard
        self.computerCard = computerCard
        result = Result.None
    }
}

class GameModel{
    
    private var playerDeck : Deck
    private var computerDeck : Deck
    
    var playerWarStack : [Card]
    var computerWarStack : [Card]
    
    var playerScore : Int
    var computerScore : Int
    
    var lastRoundResult : Result
    init() {
        playerDeck = Deck(clubs_spades: true)
        computerDeck = Deck(clubs_spades: false)
        playerWarStack = [Card]()
        computerWarStack = [Card]()
        playerScore = 0
        computerScore = 0
        lastRoundResult = Result.None
    }
    
    func startRound() -> RoundResult{
        
        let playerCard = playerDeck.getNextRandomCard()
        let computerCard = computerDeck.getNextRandomCard()
        
        var roundResult = RoundResult(playerCard: playerCard, computerCard: computerCard)
        if playerCard == nil || computerCard == nil{
            roundResult.result = Result.GameEnd
            return roundResult
        }
        
        playerWarStack.append(playerCard!)
        computerWarStack.append(computerCard!)
        
        if isWarPassCard(){
            roundResult.result = Result.War
            return roundResult
        }
        
        roundResult.result = compareCards(playerCard: playerCard!, computerCard: computerCard!)
        
        return roundResult
    }
    
    func compareCards(playerCard : Card, computerCard : Card) -> Result{
    
        if playerCard.value > computerCard.value{
            playerScore += playerWarStack.count + computerWarStack.count
            updateDeck(deck: playerDeck)
            return Result.Win
        }
        else if playerCard.value < computerCard.value{
            computerScore += playerWarStack.count + computerWarStack.count
            updateDeck(deck: computerDeck)
            return Result.Lose
        }
        else{
            return Result.War
        }
    }
    
    func updateDeck(deck : Deck){
        deck.cards.append(contentsOf: playerWarStack)
        deck.cards.append(contentsOf: computerWarStack)
    }
    
    func roundEnd(result : Result){
        lastRoundResult = result
        if result != Result.War{
            playerWarStack.removeAll()
            computerWarStack.removeAll()
        }
    }
    
    func isPlayerWinGame() -> String{
        
        if playerScore >= computerScore{
            return "You Win"
        }
        else{
            return "You lose"
        }
    }
    
    func getPlayerRemaningCards() -> Int{
        return playerDeck.cards.count
    }
    func getComputerRemaningCards() -> Int{
        return computerDeck.cards.count
    }
    func isWarPassCard() -> Bool{
        if (playerWarStack.count % 2) == 0 { return true } else { return false }
    }
    
}
