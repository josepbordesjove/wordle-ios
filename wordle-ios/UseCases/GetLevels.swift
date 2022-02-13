import Combine

struct GetLevels {
    typealias UseCase = () -> AnyPublisher<[Level], Error>
    
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Level], Error> {
        repository.getLevels()
    }
}
