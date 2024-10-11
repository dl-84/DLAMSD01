import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    /// The button for the level easy.
    @IBOutlet weak var buttonLevelEasy: UIButton!
    
    /// The button for the level middle.
    @IBOutlet weak var buttonLevelMiddle: UIButton!
    
    /// The button for the level hard.
    @IBOutlet weak var buttonLevelHard: UIButton!
    
    /// The progress bar.
    @IBOutlet weak var questionProgressBar: UIProgressView!
    
    /// The label for progress text.
    @IBOutlet weak var questionProgressText: UILabel!
    
    /// The label for the question text.
    @IBOutlet weak var questionText: UILabel!
    
    /// The answer textfield.
    @IBOutlet weak var questionAnswer: UITextField!
    
    /// The cancel button.
    @IBOutlet weak var questionCancel: UIButton!
    
    /// The button to send the answer.
    @IBOutlet weak var questionSendAnswer: UIButton!
    
    /// The label for the result face on left side.
    @IBOutlet weak var resultFaceLeft: UILabel!
    
    /// The label for the result face on right side.
    @IBOutlet weak var resultFaceRight: UILabel!
    
    /// The label for an information text at the result area.
    @IBOutlet weak var resultInfo: UILabel!
    
    /// The label to show the scored points.
    @IBOutlet weak var resultPoints: UILabel!
    
    /// The result service.
    var resultService: ResultService!
    
    /// The question service.
    var questionsService: QuestionsService!
    
    /// The quiz service.
    var quizService: QuizService!
    
    /// The view did load function.
    override func viewDidLoad() {
        super.viewDidLoad()
        initQuizApp()
    }
    
    /// Hides the keybord on touch outside of the textfield.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Initialize the quiz app.
    func initQuizApp() {
        questionsService = QuestionsService()
        
        resultService = ResultService(
                            faceLeft: resultFaceLeft,
                            faceRight: resultFaceRight,
                            info: resultInfo,
                            points: resultPoints)
        
        quizService = QuizService(
                            progressBar: questionProgressBar,
                            progressText: questionProgressText,
                            questionText: questionText,
                            answer: questionAnswer,
                            cancel: questionCancel,
                            sendAnswer: questionSendAnswer,
                            questionsService: questionsService,
                            resultService: resultService)
    }
    
    /// The click handler for the easy level button.
    @IBAction func buttonLevelEasyClick(_ sender: Any) {
        quizService.startQuiz(level: .easy)
    }
    
    /// The click handler for the medium level button.
    @IBAction func buttonLevelMediumClick(_ sender: Any) {
        quizService.startQuiz(level: .medium)
    }
    
    /// The click handler for the hard level button.
    @IBAction func buttonLevelHardClick(_ sender: Any) {
        quizService.startQuiz(level: .hard)
    }
    
    /// The click handler for the cancel quiz button.
    @IBAction func buttonCancelQuiz(_ sender: Any) {
        quizService.cancelQuiz()
    }
    
    /// The click handle for the send answer button.
    @IBAction func buttonSendAnswer(_ sender: Any) {
        quizService.process(givenAnswer: questionAnswer.text!)
    }
}
