import Combine

enum InMemoryStoreError: Error {
    case failedToRetrieveWordsList
    case failedToRetrieveLevels
    case failedToRetrieveFunFactsList
}

protocol InMemoryStoring {
    func getLevels() -> AnyPublisher<[Level], Error>
    func getWordsList() -> AnyPublisher<WordsList, Error>
    func getFunFacts() -> AnyPublisher<FunFactsList, Error>
}

final class InMemoryStore: InMemoryStoring {
    enum Constant {
        static let levelsJsonFileName = "levels"
        static let wordsListJsonFileName = "words_five_letter_list"
        static let funFactsJsonFileName = "fun_facts"
    }

    private let localFileManager: LocalFileManager

    init(localFileManager: LocalFileManager = LocalFileManager()) {
        self.localFileManager = localFileManager
    }
    
    func getWordsList() -> AnyPublisher<WordsList, Error> {
        guard let data = localFileManager.retrieveSyncJson(name: Constant.wordsListJsonFileName, type: WordsList.self) else {
            return Fail(error: InMemoryStoreError.failedToRetrieveWordsList)
                .eraseToAnyPublisher()
        }
        
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getLevels() -> AnyPublisher<[Level], Error> {
        guard let data = localFileManager.retrieveSyncJson(name: Constant.levelsJsonFileName, type: Levels.self) else {
            return Fail(error: InMemoryStoreError.failedToRetrieveLevels)
                .eraseToAnyPublisher()
        }
        
        return Just(data.levels)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getFunFacts() -> AnyPublisher<FunFactsList, Error> {
        guard let data = localFileManager.retrieveSyncJson(name: Constant.funFactsJsonFileName, type: FunFactsList.self) else {
            return Fail(error: InMemoryStoreError.failedToRetrieveFunFactsList)
                .eraseToAnyPublisher()
        }
        
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
