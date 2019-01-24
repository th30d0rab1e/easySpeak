//
//  ViewController.swift
//  SpeakScott
//
//  Created by Theodore Cross on 4/17/18.
//  Copyright © 2018 Theodore Cross. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    var listOfQuestions  : [List] = []
    var index = 0;
    var word:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture
        
        addViews();
        addTestData();
        
        theLabel.text = listOfQuestions[index].question
        wordLabel.text = word;
        
        let string:String! = listOfQuestions[index].question
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addViews(){
        let screenSize: CGRect = UIScreen.main.bounds
        //top
        let topView = UIView(frame: CGRect(x: screenSize.width * 0.20, y: 0, width: screenSize.width * 0.60, height: screenSize.height * 0.50))
        self.view.addSubview(topView)
        topView.backgroundColor = UIColor.blue.withAlphaComponent(0.10);
        let tapGestureTop = UITapGestureRecognizer(target: self, action: #selector(handleTapTop(sender:)))
        topView.addGestureRecognizer(tapGestureTop);
        
        //bottom
        let bottomView = UIView(frame: CGRect(x: screenSize.width * 0.20, y: screenSize.height * 0.50, width: screenSize.width * 0.60, height: screenSize.height * 0.50))
        self.view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.green.withAlphaComponent(0.10);
        let tapGestureBottom = UITapGestureRecognizer(target: self, action: #selector(handleTapBottom(sender:)))
        bottomView.addGestureRecognizer(tapGestureBottom);
        
        //right
        let rightView = UIView(frame: CGRect(x: screenSize.width * 0.80, y: 0, width: screenSize.width * 0.20, height: screenSize.height))
        self.view.addSubview(rightView)
        rightView.backgroundColor = UIColor.red.withAlphaComponent(0.10);
        let tapGestureRight = UITapGestureRecognizer(target: self, action: #selector(handleTapRight(sender:)))
        rightView.addGestureRecognizer(tapGestureRight);
        
        //left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 0.20, height: screenSize.height))
        self.view.addSubview(leftView)
        leftView.backgroundColor = UIColor.red.withAlphaComponent(0.10);
        let tapGestureLeft = UITapGestureRecognizer(target: self, action: #selector(handleTapLeft(sender:)))
        leftView.addGestureRecognizer(tapGestureLeft);
    }

    //top
    @objc func handleTapTop(sender: UITapGestureRecognizer) {
        print("tap top")
        swipeLabel.text = "Tapped Top"
        
        //Letter Added to Word
        if (listOfQuestions[index].type == 1)
        {
            word += listOfQuestions[index].question;
            wordLabel.text = word;
            let string:String! = listOfQuestions[index].approval + " , " + word;
            let utterance = AVSpeechUtterance(string: string!);
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
            
        }
        else {
            let string:String! = listOfQuestions[index].approval
            let utterance = AVSpeechUtterance(string: string!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
        }
    }
    
    //bottom
    @objc func handleTapBottom(sender: UITapGestureRecognizer) {
        print("tap bottom")
        swipeLabel.text = "Tapped Bottom"
        
        //Letter Added to Word
        if (listOfQuestions[index].type == 1)
        {
            word = String(word.characters.dropLast());
            wordLabel.text = word;
            if(word != "") {
                let string:String! = listOfQuestions[index].rejection + " , " + word;
                let utterance = AVSpeechUtterance(string: string!)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                let synth = AVSpeechSynthesizer()
                synth.speak(utterance)
            }
        }
        else {
            let string:String! = listOfQuestions[index].rejection;
            let utterance = AVSpeechUtterance(string: string!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
        }
    }
    
    //left
    @objc func handleTapLeft(sender: UITapGestureRecognizer) {
        print("tap left")
        swipeLabel.text = "Tapped Left"
        index = index - 1;
        
        print("Index is currently ", index)
        print("Count of array is ", listOfQuestions.count)
        
        if (index == -1){
            index = listOfQuestions.count - 1
        }
        
        speakNext(entity: index)
    }
    
    //right
    @objc func handleTapRight(sender: UITapGestureRecognizer) {
        print("tap right")
        swipeLabel.text = "Tapped Right"
        index = index + 1;
        
        print("Index is currently ", index)
        print("Count of array is ", listOfQuestions.count)
        
        if (index == listOfQuestions.count){
            print("k im gonna fix it?")
            index = 0
        }
        speakNext(entity: index)
    }
    
    func speakNext(entity: Int){
        let string:String! = listOfQuestions[index].question
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        
        theLabel.text = string
    }
    
    //handle phone rotatte
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let screenSize: CGRect = UIScreen.main.bounds;
        //top
        let topView = UIView(frame: CGRect(x: screenSize.width * 0.20, y: 0, width: screenSize.width * 0.60, height: screenSize.height * 0.50))
        //bottom
        let bottomView = UIView(frame: CGRect(x: screenSize.width * 0.20, y: screenSize.height * 0.50, width: screenSize.width * 0.60, height: screenSize.height * 0.50))
        //right
        let rightView = UIView(frame: CGRect(x: screenSize.width * 0.80, y: 0, width: screenSize.width * 0.20, height: screenSize.height))
        //left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 0.20, height: screenSize.height))
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    //Swiped Right
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swiped Right"
        index = index + 1;
        
        print("Index is currently ", index)
        print("Count of array is ", listOfQuestions.count)
        
        if (index == listOfQuestions.count){
            print("k im gonna fix it?")
            index = 0
        }
        speakNext(entity: index)
    }
    
    //Swiped Left
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swiped Left"
        index = index - 1;
        
        print("Index is currently ", index)
        print("Count of array is ", listOfQuestions.count)
        
        if (index == -1){
            print("k im gonna fix it?")
            index = listOfQuestions.count - 1
        }
        
        speakNext(entity: index)
    }
    //Swiped Up
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swiped Up"
        let string:String! = listOfQuestions[index].approval
        let utterance = AVSpeechUtterance(string: string!)
        
        print(index)
        print(string)
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        
        //Letter Added to Word
        if (listOfQuestions[index].type == 1)
        {
            word += listOfQuestions[index].question
            print("Word is", word)
        }
        
    }
    //Swiped Down
    @IBAction func SwipeDown(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swiped Down"
        let string:String! = listOfQuestions[index].rejection
        let utterance = AVSpeechUtterance(string: string)
        
        print(index)
        print(string)
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        
        //Letter Added to Word
        if (listOfQuestions[index].type == 1)
        {
            word = String(word.characters.dropLast())
            print("Word is", word)
        }
    }
    
    func addTestData() {
        //test data
        
        let x = List()
        x.question = "Do you want some food?"
        x.approval = "Yes, I want some food."
        x.rejection = "No, I do not want some food.";
        
        let y = List()
        y.question = "Do you want some water?"
        y.approval = "Yes, I want some water."
        y.rejection = "No, I do not want some water."
        
        let z = List()
        z.question = "Do you want some help?"
        z.approval = "Yes, I want some help."
        z.rejection = "No, I do not want some help."
        
        let letterA = List()
        letterA.question = "A"
        letterA.approval = "The letter A added to word"
        letterA.rejection = "Removed"
        letterA.type = 1
        
        let letterB = List()
        letterB.question = "B"
        letterB.approval = "B added to word"
        letterB.rejection = "Removed"
        letterB.type = 1
        
        let letterC = List()
        letterC.question = "C"
        letterC.approval = "C added to word"
        letterC.rejection = "Removed"
        letterC.type = 1
        
        let letterD = List()
        letterD.question = "D"
        letterD.approval = "D added to word"
        letterD.rejection = "Removed"
        letterD.type = 1
        
        let letterE = List()
        letterE.question = "E"
        letterE.approval = "E added to word"
        letterE.rejection = "Removed"
        letterE.type = 1
        
        let letterF = List()
        letterF.question = "F"
        letterF.approval = "F added to word"
        letterF.rejection = "Removed"
        letterF.type = 1
        
        let letterG = List()
        letterG.question = "G"
        letterG.approval = "G added to word"
        letterG.rejection = "Removed"
        letterG.type = 1
        
        let letterH = List()
        letterH.question = "H"
        letterH.approval = "H added to word"
        letterH.rejection = "Removed"
        letterH.type = 1
        
        let letterI = List()
        letterI.question = "I"
        letterI.approval = "I added to word"
        letterI.rejection = "Removed"
        letterI.type = 1
        
        let letterJ = List()
        letterJ.question = "J"
        letterJ.approval = "J added to word"
        letterJ.rejection = "Removed"
        letterJ.type = 1
        
        let letterK = List()
        letterK.question = "K"
        letterK.approval = "K added to word"
        letterK.rejection = "Removed"
        letterK.type = 1
        
        let letterL = List()
        letterL.question = "L"
        letterL.approval = "L added to word"
        letterL.rejection = "Removed"
        letterL.type = 1
        
        let letterM = List()
        letterM.question = "M"
        letterM.approval = "M added to word"
        letterM.rejection = "Removed"
        letterM.type = 1
        
        let letterN = List()
        letterN.question = "N"
        letterN.approval = "N added to word"
        letterN.rejection = "Removed"
        letterN.type = 1
        
        let letterO = List()
        letterO.question = "O"
        letterO.approval = "O added to word"
        letterO.rejection = "Removed"
        letterO.type = 1
        
        let letterP = List()
        letterP.question = "P"
        letterP.approval = "P added to word"
        letterP.rejection = "Removed"
        letterP.type = 1
        
        let letterQ = List()
        letterQ.question = "Q"
        letterQ.approval = "Q added to word"
        letterQ.rejection = "Removed"
        letterQ.type = 1
        
        let letterR = List()
        letterR.question = "R"
        letterR.approval = "R added to word"
        letterR.rejection = "Removed"
        letterR.type = 1
        
        let letterS = List()
        letterS.question = "S"
        letterS.approval = "S added to word"
        letterS.rejection = "Removed"
        letterS.type = 1
        
        let letterT = List()
        letterT.question = "T"
        letterT.approval = "T added to word"
        letterT.rejection = "Removed"
        letterT.type = 1
        
        let letterU = List()
        letterU.question = "U"
        letterU.approval = "U added to word"
        letterU.rejection = "Removed"
        letterU.type = 1
        
        let letterV = List()
        letterV.question = "V"
        letterV.approval = "V added to word"
        letterV.rejection = "Removed"
        letterV.type = 1
        
        let letterW = List()
        letterW.question = "W"
        letterW.approval = "W added to word"
        letterW.rejection = "Removed"
        letterW.type = 1
        
        let letterX = List()
        letterX.question = "X"
        letterX.approval = "X added to word"
        letterX.rejection = "Removed"
        letterX.type = 1
        
        let letterY = List()
        letterY.question = "Y"
        letterY.approval = "Y added to word"
        letterY.rejection = "Removed"
        letterY.type = 1
        
        let letterZ = List()
        letterZ.question = "Z"
        letterZ.approval = "Z added to word"
        letterZ.rejection = "Removed"
        letterZ.type = 1
        
        listOfQuestions = [ x, y, z, letterA, letterB, letterC,letterD,letterE,letterF, letterG, letterH, letterI,letterJ, letterK, letterL, letterM, letterN, letterO, letterP, letterQ, letterR, letterS, letterT, letterU, letterV, letterW, letterX, letterY, letterZ]
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    func SpeakWord() {
        print("ahem " + word);
        if (wordLabel.text != ""){
            let string:String! = word
            let utterance = AVSpeechUtterance(string: string!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
        }
    }
}

