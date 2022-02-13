import Combine

struct GetNextLevel {
    typealias UseCase = () -> AnyPublisher<Level, Error>
        
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<Level, Error> {
        repository.getNextLevel()
    }
}
