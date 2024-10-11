/// The question dto.
public struct QuestionDto: Decodable {
    /// The indentifier.
    let id: Int
    
    /// The quiz level.
    let level: QuizLevel
    
    /// The question.
    let question: String
    
    /// The solution.
    let solution: String
}
