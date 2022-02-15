import Combine
import Foundation

struct IsWordContainedInList {
    typealias UseCase = (String) -> AnyPublisher<Bool, Error>
    
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute(word: String) -> AnyPublisher<Bool, Error> {
        repository.getWordsList().flatMap { wordsList -> AnyPublisher<Bool, Error> in
            let wordsListPreparedToCompare = wordsList.words
                .filter({ $0.count == 5 })
                .map({ prepareStringForPlain($0) })
            let plainWordToCompare = prepareStringForPlain(word)
            let isWordContained = wordsListPreparedToCompare.contains(plainWordToCompare)
            return Just(isWordContained)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    private func prepareStringForPlain(_ string: String) -> String {
        let simple = string.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
