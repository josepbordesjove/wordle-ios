import Combine

struct GetNextLevel {
    typealias UseCase = () -> AnyPublisher<Level?, Error>
        
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<Level?, Error> {
        return repository.getFinishedLevels().flatMap { (finishedLevels) -> AnyPublisher<Level?, Error> in
            return repository.getLevels().flatMap { (levels) -> AnyPublisher<Level?, Error> in
                let level = levels
                    .filter { self.filterUnfinishedLevels(finishedLevels: finishedLevels, level: $0) }
                    .sorted { $0.sortableKey < $1.sortableKey }
                    .first

                return Just(level)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: Helpers
    
    private func filterUnfinishedLevels(finishedLevels: [LevelFinished], level: Level) -> Bool {
        let isLevelFinished = finishedLevels.contains { $0.levelId == level.id }
        return !isLevelFinished
    }
}
