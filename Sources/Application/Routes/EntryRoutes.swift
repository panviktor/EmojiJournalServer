//
//  EntryRoutes.swift
//  
//
//  Created by Viktor on 11.09.2020.
//


import Foundation
import LoggerAPI
import Kitura

var entries: [JournalEntry] = []

func initializeEntryRoutes(app: App) {
    app.router.get("/entries", handler: getEntries)
    app.router.post("/entries", handler: addEntry)
    app.router.delete("/entries", handler: deleteEntry)
    app.router.put("/entries", handler: modifyEntry)
    app.router.get("/entries", handler: getOneEntry)
    Log.info("Journal entry routes created")
}

func addEntry(user: UserAuth, entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    var savedEntry = entry
    savedEntry.id = UUID().uuidString
    savedEntry.save(completion)
}

func getEntries(user: UserAuth, query: JournalEntryParams?, completion: @escaping ([JournalEntry]?, RequestError?) -> Void) -> Void {
    JournalEntry.findAll(matching: query, completion)
}

func deleteEntry(user: UserAuth, id: String, completion: @escaping (RequestError?) -> Void) {
    JournalEntry.delete(id: id, completion)
}

func modifyEntry(user: UserAuth, id: String, entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    entry.update(id: id, completion)
}

func getOneEntry(user: UserAuth, id: String, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    JournalEntry.find(id: id, completion)
}
