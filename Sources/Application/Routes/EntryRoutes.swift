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


func addEntry(entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    var storedEntry = entry
    storedEntry.id = entries.count.value
    entries.append(storedEntry)
    completion(storedEntry, nil)
}

func getEntries(params: JournalEntryParams?, completion: @escaping ([JournalEntry]?, RequestError?) -> Void) -> Void {
    guard let params = params else {
        return completion(entries, nil)
    }
    let filteredEntries = entries.filter { $0.emoji == params.emoji }
    completion(filteredEntries, nil)
}

func deleteEntry(id: String, completion: @escaping (RequestError?) -> Void) {
    guard let index = entries.firstIndex(where: { $0.id == id }) else {
        return completion(.notFound)
    }
    entries.remove(at: index)
    completion(nil)
}

func modifyEntry(id: String, entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    guard let index = entries.firstIndex(where: { $0.id == id }) else {
        return completion(nil, .notFound)
    }
    var storedEntry = entry
    storedEntry.id = id
    entries[index] = storedEntry
    completion(storedEntry, nil)
}

func getOneEntry(id: String, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    guard let index = entries.firstIndex(where: { $0.id == id }) else {
        return completion(nil, .notFound)
    }
    completion(entries[index], nil)
}

