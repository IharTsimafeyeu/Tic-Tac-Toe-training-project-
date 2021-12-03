//
//  ViewController.swift
//  Tic Tac Toe (training project)
//
//  Created by Игорь Тимофеев on 3.12.21.
//

import UIKit

import UIKit

enum Turn {
    case Cross
    case Nought
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    private var firstTurn = Turn.Cross
    private var currentTurn = Turn.Cross
    
    private let noughtLetter = "0"
    private let crossLetter = "X"
    private var boardArray = [UIButton]()
    
    private var noughtsScore = 0
    private var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
}

//MARK: Functions
extension ViewController {
    @IBAction private func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
        if checkForVictory(crossLetter) {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(noughtLetter) {
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
    }
    
    private func addToBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if currentTurn == Turn.Nought {
                sender.setTitle(noughtLetter, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = crossLetter
            } else if currentTurn == Turn.Cross {
                sender.setTitle(crossLetter, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = noughtLetter
            }
            sender.isEnabled = false
        }
    }
    private func initBoard() {
        boardArray.append(one)
        boardArray.append(two)
        boardArray.append(three)
        boardArray.append(four)
        boardArray.append(five)
        boardArray.append(six)
        boardArray.append(seven)
        boardArray.append(eight)
        boardArray.append(nine)
    }
    private func fullBoard() -> Bool {
        for button in boardArray {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    private func resultAlert(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resetBoard() }))
        self.present(ac, animated: true)
    }
    
    private func checkForVictory(_ s :String) -> Bool {
        // Horizontal Victory
        if thisSymbol(one, s) && thisSymbol(two, s) && thisSymbol(three, s) {
            return true
        }
        if thisSymbol(four, s) && thisSymbol(five, s) && thisSymbol(six, s) {
            return true
        }
        if thisSymbol(seven, s) && thisSymbol(eight, s) && thisSymbol(nine, s) {
            return true
        }
        
        // Vertical Victory
        if thisSymbol(one, s) && thisSymbol(four, s) && thisSymbol(seven, s) {
            return true
        }
        if thisSymbol(two, s) && thisSymbol(five, s) && thisSymbol(eight, s) {
            return true
        }
        if thisSymbol(three, s) && thisSymbol(six, s) && thisSymbol(nine, s) {
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(one, s) && thisSymbol(five, s) && thisSymbol(nine, s) {
            return true
        }
        if thisSymbol(three, s) && thisSymbol(five, s) && thisSymbol(seven, s) {
            return true
        }
        return false
    }
    
    private func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    private func resetBoard() {
        for button in boardArray {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = crossLetter
        } else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = noughtLetter
        }
        currentTurn = firstTurn
    }
}
