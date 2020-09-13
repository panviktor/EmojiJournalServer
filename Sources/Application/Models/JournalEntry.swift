import Foundation
import KituraContracts
import SwiftKueryORM

struct JournalEntry: Model {
  var id: String?
  var emoji: String
  var date: Date
}

struct JournalEntryParams: QueryParams {
 var emoji: String?
}
