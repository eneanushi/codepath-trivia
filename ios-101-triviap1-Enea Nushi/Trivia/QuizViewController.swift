import UIKit

class QuizViewController: UIViewController {
    
    var Questions = [Question]()
    var questionsNumber = Int()
    
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    
    @IBAction func Button1(_ sender: UIButton) {
        moveToNextQuestion()
    }
    
    @IBAction func Button2(_ sender: UIButton) {
        moveToNextQuestion()
    }
    
    
    @IBAction func Button3(_ sender: UIButton) {
        moveToNextQuestion()
    }
    
    
    
    
    @IBAction func Button4(_ sender: UIButton){
        moveToNextQuestion()
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Questions = [
            Question(Question: "Is CodePath worth it?", Answers: ["no", "maybe", "10000% yes", "I guess"], correctAnswerIndex: 2),
            Question(Question: "Was trivia project hard?", Answers: ["A little bit", "Oh Yes", "No", "No comment"], correctAnswerIndex: 1),
            Question(Question: "How much is 2+2*2", Answers: ["8", "0", "Not sure", "6"], correctAnswerIndex: 3),
            Question(Question: "Which one is a fruit", Answers: ["apple", "banana", "mango", "all of them"], correctAnswerIndex: 3),
            Question(Question: "How old am I?", Answers: ["19", "Just turned 20", "no idea bro", "1200"], correctAnswerIndex: 1)
        ]
        questionPicker()
    }
    
    func questionPicker(){
        if questionsNumber < Questions.count {
            questionLabel.text = Questions[questionsNumber].Question
            
            let currentAnswers = Questions[questionsNumber].Answers
            button1.setTitle(currentAnswers?[0], for: .normal)
            button2.setTitle(currentAnswers?[1], for: .normal)
            button3.setTitle(currentAnswers?[2], for: .normal)
            button4.setTitle(currentAnswers?[3], for: .normal)
        }
        else {
                resetGame() 
            }
       
    }
    
    func moveToNextQuestion() {
        questionsNumber += 1
        questionPicker()
    }
    
    func resetGame() {
           questionsNumber = 0
           questionPicker()
       }
}

struct Question{
    var Question: String!
    var Answers : [String]!
    var correctAnswerIndex : Int!
}
