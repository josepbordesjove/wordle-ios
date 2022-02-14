import Combine

struct StoreFinishedLevel {
    typealias UseCase = (Level, Int, Bool) -> AnyPublisher<Bool, Error>
        
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error> {
        repository.storeFinishedLevel(level: level, tries: tries, success: success)
    }
}
