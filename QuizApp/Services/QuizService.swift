import UIKit

/// The quiz service class.
class QuizService {
    /// The progress bar.
    private let progressBar: UIProgressView!
    
    /// The label for progress text.
    private let progressText: UILabel!
    
    /// The label for the question text.
    private let questionText: UILabel!
    
    /// The answer textfield.
    private let answer: UITextField!
    
    /// The cancel button.
    private let cancel: UIButton!
    
    /// The button to send the answer.
    private let sendAnswer: UIButton!
    
    /// The question service.
    private let questionsService: QuestionsService
    
    /// The result service.
    private let resultService: ResultService

    /// The current question index.
    private var index: Int = 0
    
    /// The counter for the correct answers.
    private var correctAnswers: Int = 0

    /// The questions for the current quiz round.
    private var questions: [QuestionDto] = []
       
    /// The construnctor of the quiz service.
    init(progressBar: UIProgressView,
         progressText: UILabel,
         questionText: UILabel,
         answer: UITextField,
         cancel: UIButton,
         sendAnswer: UIButton,
         questionsService: QuestionsService,
         resultService: ResultService)
    {
        self.progressBar = progressBar
        self.progressText = progressText
        self.questionText = questionText
        self.answer = answer
        self.cancel = cancel
        self.sendAnswer = sendAnswer
        self.questionsService = questionsService
        self.resultService = resultService
    }
    
    /// Start an new round.
    public func startQuiz(level: QuizLevel) {
        resetVariables()
        controls(visible: true)
        resultService.hideResult()
        questions = questionsService.Deliver(level: level)
        updateProgressBar()
        updateProgressText()
        updateQuestionText()
    }
    
    /// Cancels the quiz round.
    public func cancelQuiz() {
        controls(visible: false)
        resetVariables()
    }
    
    /// The process procedure.
    public func process(givenAnswer: String) {
        if checkAnswer(givenAnswer: givenAnswer) {
            correctAnswers += 1
        }
        
        index += 1
        
        if index < questions.count {
            updateProgressBar()
            updateProgressText()
            updateQuestionText()
            answer.text = ""
        }
        else {
            // levelControls(enable: true) hier muss noch was passieren
            controls(visible: false)
            resultService.showResult(correctAnswers: correctAnswers, numberOfQuestions: questions.count)
            resetVariables()
        }
    }
    
    /// Hides the keyboard when the enter button ist pressed.
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return answer.resignFirstResponder()
    }
    
    /// Controls the visibility of als quiz controls.
    private func controls(visible: Bool) {
        progressBar.isHidden = !visible
        progressText.isHidden = !visible
        questionText.isHidden = !visible
        answer.isHidden = !visible
        cancel.isHidden = !visible
        sendAnswer.isHidden = !visible
    }
    
    /// Resets the quiz control variables.
    private func resetVariables() {
        index = 0
        correctAnswers = 0
        questions = []
    }
    
    /// Checks the given answer.
    private func checkAnswer(givenAnswer: String) -> Bool {
        let given = givenAnswer
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        let solution = questions[index].solution.lowercased()
        
        if given != solution {
            return false
        }
        
        return true
    }
    
    /// Updates the value of the progress bar.
    private func updateProgressBar() {
        progressBar.progress = Float(index + 1) / Float(questions.count)
    }
    
    /// Updates the value of the progress text.
    private func updateProgressText() {
        progressText.text = String(format: "Frage %d von %d", index + 1, questions.count)
    }
    
    /// Updates the question text.
    private func updateQuestionText() {
        questionText.text = questions[index].question
    }
}
