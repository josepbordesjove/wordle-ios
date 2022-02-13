import Combine

struct GetFinishedLevels {
    typealias UseCase = () -> AnyPublisher<[LevelFinished], Error>
        
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[LevelFinished], Error> {
        repository.getFinishedLevels()
    }
}
