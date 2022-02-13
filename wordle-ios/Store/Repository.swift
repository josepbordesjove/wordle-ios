import Combine

enum RepositoryError: Error {
    case failedUnwrappingSelf
}

protocol Repositoring {
    func getLevels() -> AnyPublisher<[Level], Error>
    func getNextLevel() -> AnyPublisher<Level?, Error>
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error>
    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error>
}

final class Repository: Repositoring {
    let coreDataStore: CoreDataStoring
    let userDefaultsStore: UserDefaultsStoring
    let inMemoryStore: InMemoryStoring
    
    init(coreDataStore: CoreDataStoring = CoreDataStore(), userDefaultsStore: UserDefaultsStoring = UserDefaultsStore(), inMemoryStore: InMemoryStoring = InMemoryStore()) {
        self.coreDataStore = coreDataStore
        self.userDefaultsStore = userDefaultsStore
        self.inMemoryStore = inMemoryStore
    }
    
    func getLevels() -> AnyPublisher<[Level], Error> {
        inMemoryStore.getLevels()
    }

    func getNextLevel() -> AnyPublisher<Level?, Error> {
        return getFinishedLevels().flatMap { [weak self] (finishedLevels) -> AnyPublisher<Level?, Error> in
            guard let self = self else {
                return Fail(error: RepositoryError.failedUnwrappingSelf)
                    .eraseToAnyPublisher()
            }
            
            return self.getLevels().flatMap { (levels) -> AnyPublisher<Level?, Error> in
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
    
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error> {
        coreDataStore.storeFinishedLevel(level: level, tries: tries, success: success)
    }

    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error> {
        coreDataStore.getFinishedLevels()
    }
    
    // MARK: Helpers
    
    private func filterUnfinishedLevels(finishedLevels: [LevelFinished], level: Level) -> Bool {
        let isLevelFinished = finishedLevels.contains { $0.levelId == level.id }
        return !isLevelFinished
    }
}
