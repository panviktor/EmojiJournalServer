import Foundation
import KituraContracts

struct JournalEntry: Codable {
  var id: String?
  var emoji: String
  var date: Date
}

struct JournalEntryParams: QueryParams {
 var emoji: String?
}
