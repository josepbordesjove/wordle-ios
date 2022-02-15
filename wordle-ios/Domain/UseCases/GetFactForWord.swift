import Combine

struct GetFactForWord {
    typealias UseCase = (String) -> AnyPublisher<FunFact?, Error>
    
    private let repository: Repositoring
        
    init(repository: Repositoring = Repository()) {
        self.repository = repository
    }
    
    func execute(word: String) -> AnyPublisher<FunFact?, Error> {
        repository.getFunFacts().flatMap { factsList -> AnyPublisher<FunFact?, Error> in
            let fact = factsList.facts
                .filter { $0.word == word }
                .first
            
            return Just(fact)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
