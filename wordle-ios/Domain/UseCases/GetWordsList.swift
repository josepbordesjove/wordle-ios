import Combine

struct GetWordsList {
    typealias UseCase = () -> AnyPublisher<WordsList, Error>
    
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<WordsList, Error> {
        repository.getWordsList()
    }
}
