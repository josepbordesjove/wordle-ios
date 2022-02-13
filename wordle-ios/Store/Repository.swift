import Combine

protocol Repositoring {
    func getLevels() -> AnyPublisher<[Level], Error>
    func getNextLevel() -> AnyPublisher<Level, Error>
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

    func getNextLevel() -> AnyPublisher<Level, Error> {
        Just(Level(key: "key_1",
                   sortableKey: 1,
                   name: "Nivell 1",
                   word: "tarda"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
