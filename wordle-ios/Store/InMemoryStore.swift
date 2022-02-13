import Combine

protocol InMemoryStoring {
    func getLevels() -> AnyPublisher<[Level], Error>
}

final class InMemoryStore: InMemoryStoring {
    enum Constant {
        static let levelsJsonFileName = "levels"
    }

    private let localFileManager: LocalFileManager

    init(localFileManager: LocalFileManager = LocalFileManager()) {
        self.localFileManager = localFileManager
    }
    
    func getLevels() -> AnyPublisher<[Level], Error> {
        guard let data = localFileManager.retrieveSyncJson(name: Constant.levelsJsonFileName, type: Levels.self) else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Just(data.levels)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
