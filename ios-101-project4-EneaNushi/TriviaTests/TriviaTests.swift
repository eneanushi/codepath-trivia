import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  private let triviaService = TriviaQuestionService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    fetchTriviaQuestions()
  }
  
  private func fetchTriviaQuestions() {
    triviaService.fetchTrivia(
      category: "YOUR_CATEGORY",   // Replace with the desired category
      amount: "10",               // Replace with the desired number of questions
      difficulty: "medium",       // Replace with the desired difficulty
      type: "multiple") {         // Replace with the desired question type
      [weak self] trivia in
      
      if let trivia = trivia {
        self?.questions = trivia
        self?.startGame()
      } else {
        // Handle the case when fetching questions fails
        // You can show an error message to the user
        print("Failed to fetch trivia questions")
      }
    }
  }
  
  private func startGame() {
    currQuestionIndex = 0
    numCorrectQuestions = 0
    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    guard questionIndex >= 0 && questionIndex < questions.count else {
      // Handle the case where questionIndex is out of range, e.g., show a message or end the game.
      return
    }
    
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    questionLabel.text = question.question
    categoryLabel.text = question.category
    let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
    
    answerButton0.setTitle(answers[0], for: .normal)
    answerButton1.setTitle(answers[1], for: .normal)
    answerButton2.setTitle(answers[2], for: .normal)
    answerButton3.setTitle(answers[3], for: .normal)
    
    // Update the visibility of answer buttons if needed.
    answerButton1.isHidden = false
    answerButton2.isHidden = false
    answerButton3.isHidden = false
  }
  
  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
    
    if currQuestionIndex < questions.count {
      updateQuestion(withQuestionIndex: currQuestionIndex)
    } else {
      showFinalScore()
    }
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
      currQuestionIndex = 0
      numCorrectQuestions = 0
      updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}
