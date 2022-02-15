import Combine

enum RepositoryError: Error {
    case failedUnwrappingSelf
}

protocol Repositoring {
    func getLevels() -> AnyPublisher<[Level], Error>
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error>
    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error>
    func getWordsList() -> AnyPublisher<WordsList, Error>
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
    
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error> {
        coreDataStore.storeFinishedLevel(level: level, tries: tries, success: success)
    }

    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error> {
        coreDataStore.getFinishedLevels()
    }
    
    func getWordsList() -> AnyPublisher<WordsList, Error> {
        inMemoryStore.getWordsList()
    }
}
