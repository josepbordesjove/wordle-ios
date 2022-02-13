import Combine
import CoreData

enum CoreDataStoreError: Error {
    case failedSavingFinishedLevel
}

protocol CoreDataStoring {
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error>
    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error>
}

final class CoreDataStore: CoreDataStoring {
    private let persistanceController: PersistenceControlling
    
    init(persistanceController: PersistenceControlling = PersistenceController.shared) {
        self.persistanceController = persistanceController
    }
    
    func storeFinishedLevel(level: Level, tries: Int, success: Bool) -> AnyPublisher<Bool, Error> {
        let newFinishedLevel = LevelFinishedManaged(context: persistanceController.container.viewContext)
        newFinishedLevel.tries = Int16(tries)
        newFinishedLevel.success = success
        newFinishedLevel.level_id = level.id
        newFinishedLevel.sortable_key = Int16(level.sortableKey)
        
        do {
            try persistanceController.container.viewContext.save()
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: CoreDataStoreError.failedSavingFinishedLevel)
                .eraseToAnyPublisher()
        }
    }
    
    func getFinishedLevels() -> AnyPublisher<[LevelFinished], Error> {
        let finishedLevelsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LevelFinishedManaged")
        let finishedLevelsManaged = (try? persistanceController.container.viewContext.fetch(finishedLevelsFetchRequest) as? [LevelFinishedManaged]) ?? []
        let finishedLevels: [LevelFinished] = finishedLevelsManaged.compactMap {
            guard let levelId = $0.level_id else { return nil }
            return LevelFinished(levelId: levelId,
                                 tries: Int($0.tries),
                                 success: $0.success,
                                 sortableKey: Int($0.sortable_key))
        }
        
        return Just(finishedLevels)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
