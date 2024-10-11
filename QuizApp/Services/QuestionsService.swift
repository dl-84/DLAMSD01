import Foundation

// The question service implementation.
public class QuestionsService {
    
    /// The question member.
    private var questions: [QuestionDto] = []
    
    /// The constructor of the question service.
    init(){
        if let url = Bundle.main.url(forResource: "Questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(QuestionsDto.self, from: data)
                questions = jsonData.questions
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    /// Deliver all questions based on the given level.
    public func Deliver(level: QuizLevel) -> [QuestionDto] {
        var result: [QuestionDto] = []
        result = questions.filter { $0.level == level }
        return result
    }
}
