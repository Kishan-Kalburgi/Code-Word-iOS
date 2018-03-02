//
//  CodeWord.swift
//  SecretCode
//
//  Created by Kalburgi Srinivas,Kishan on 3/1/18.
//  Copyright © 2018 Kalburgi Srinivas,Kishan. All rights reserved.
//

import Foundation

class CodeWord {
    
    private var _symbols:[String] = []
    private var _count: Int = 0
    private var _code: [String] = []
    private var _guess:[String] = []
    private var _onSymbol: Int = 0
    private var _attempts: Int = 1
    private var _status: String = ""
    private var _correctGuessCount: Int = 0
    
    var symbols:[String] {
        get{
            return _symbols
        }
    }
    
    var count: Int {
        get {
            return _count
        }
    }
    
    var onSymbol: Int {
        get{
            return _onSymbol
        }
    }
    
    var attempts: Int {
        get {
            return _attempts
        }
    }
    
    var status: String {
        get {
            return _status
        }
    }
    
    var code: [String] {
        get {
            return _code
        }
    }
    
    var guess: [String] {
        get {
            return _guess
        }
    }
    
    
    init(sizeOfCode: Int){
        _count = sizeOfCode
        setSymbols(symbolType: "String")
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        _code = generateCode()
    }
    
    
    func setSymbols(symbolType: String){
        
        _symbols = []
        let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let kannada: [String] = ["ಅ","ಇ","ಉ","ಎ","ಗ","ಖ","ದ","ರ","ಋ"]
        
        for _ in 0 ..< _count {
            if symbolType == "String" {
                let random = Int(arc4random_uniform(UInt32(alphabet.count)))
                _symbols.append(alphabet[random])
            }
            else if symbolType == "Int" {
                let random = Int(arc4random_uniform(5))
                _symbols.append(String(random))
            }
            else if symbolType == "language"{
                let random = Int(arc4random_uniform(UInt32(kannada.count)))
                _symbols.append(kannada[random])
            }
        }
    }
    
    func correctGuess() -> Bool {
        var correct = 0;
        for i in 0 ..< _guess.count{
            if _guess[i] == _code[i] {
                correct += 1
            }
        }
        _correctGuessCount = correct
        return _correctGuessCount == _count
    }
    
    func generateCode() -> [String] {
        var code:[String] = []
        for _ in 0 ..< _count {
            let rand:Int = Int(arc4random_uniform(UInt32(_symbols.count)))
            code.append(_symbols[rand])
        }
        return code
    }
    
    func addSymbolToGuess(symbol:String) {
        if _onSymbol < _count-1 {
            _guess.append(symbol)
            _onSymbol += 1
            _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        } else{
            if _attempts == 5 {
                _guess.append(symbol)
                _status = "Guess \(_attempts) completed: \(_correctGuessCount) correct"
                _onSymbol = 0
                _attempts += 1
            }else
            {
                if _count-1 == _guess.count {
                    _guess.append(symbol)
                }
                if _correctGuessCount == _count {
                    _status = "Guess \(_attempts) completed: \(_correctGuessCount) correct"
                } else {
                    _status = "Unbroken Code – Press reset to start again."
                    
                }
            }
            if _symbols.count>0 && (Int)(UnicodeScalar(_symbols[0])!.value) >= 48
                && (Int)(UnicodeScalar(_symbols[_symbols.count-1])!.value) <= 57 {
                var sum = 0
                for i in 0 ..< _guess.count {
                    let temp = Int(_guess[i])! - Int(_code[i])!
                    if temp < 0 {
                        sum += temp * -1
                    } else {
                        sum += temp
                    }
                }
                _status += "\nSum of differences is \(sum)"
            }
        }
    }
    
    
    func getStatusMessage() -> String {
        return _status
    }
    
    func getCurrentGuess() -> String {
        var guess = ""
        for i in 0 ..< _guess.count {
            guess += "  " + _guess[i]
        }
        for _ in _guess.count ..< _count {
            guess += "  *"
        }
        return guess
    }
    
    func resetGuess(){
        _guess = []
    }
    
    func reset(){
        _code = generateCode()
        resetGuess()
        _onSymbol = 0
        _attempts = 1
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
    }
    
    func undoLastGuess(){
        if _guess.count != 0 {
            _guess.removeLast()
            _onSymbol -= 1
            _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        }
    }
    
    func hint() -> String {
        for i in 0 ..< _symbols.count {
            if _symbols[i] == _code[_onSymbol] {
                return "One of the symbols in the code is \(_symbols[i])"
            }
        }
        return "Sorry, no hint available!"
    }
}
