import UIKit

/// The result service.
class ResultService {
    /// The label for the result face on left side.
    private let faceLeft: UILabel!
    
    /// The label for the result face on right side.
    private let faceRight: UILabel!
    
    /// The label for an information text at the result area.
    private let info: UILabel!
    
    /// The label to show the scored points.
    private let points: UILabel!
        
    /// The constructor of the result service.
    init (faceLeft: UILabel!, faceRight: UILabel!, info: UILabel!, points: UILabel!) {
        self.faceLeft = faceLeft
        self.faceRight = faceRight
        self.info = info
        self.points = points
    }
    
    /// Shows the result based on the correct answers.
    public func showResult(correctAnswers: Int, numberOfQuestions: Int){
        setEmojis(correctAnswers: correctAnswers)
        setPoints(correctAnswers: correctAnswers, numberOfQuestions: numberOfQuestions)
        controls(visible: true);
    }
    
    /// Hides the result controls.
    public func hideResult() {
        controls(visible: false);
    }
    
    /// Controls the visibility of als result controls.
    private func controls(visible : Bool) {
        faceLeft.isHidden = !visible
        faceRight.isHidden = !visible
        info.isHidden = !visible
        points.isHidden = !visible
    }
    
    /// Sets the emojies to the labels based on the correct answers.
    private func setEmojis(correctAnswers: Int) {
        if correctAnswers >= 4 {
            faceLeft.text = "🥳"
            faceRight.text = "🥳"
        }
        else if correctAnswers >= 1 {
            faceLeft.text = "😐"
            faceRight.text = "😐"
        }
        else {
            faceLeft.text = "☹️"
            faceRight.text = "☹️"
        }
    }
    
    /// Sets the result points text.
    private func setPoints(correctAnswers: Int, numberOfQuestions: Int) {
        points.text =
            String(correctAnswers) + " von " + String(numberOfQuestions)
    }
}
