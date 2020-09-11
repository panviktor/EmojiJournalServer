//
//  EntryRoutes.swift
//  
//
//  Created by Viktor on 11.09.2020.
//

import Foundation
import LoggerAPI
import Kitura

/// kitura func
func initializeEntryRoutes(app: App) {
    app.router.post("/entries", handler: addEntry)
    Log.info("Journal entry routes created")
}

///my func
func addEntry(request: RouterRequest, response: RouterResponse,
              next: @escaping () -> Void) {
    guard let contentType = request.headers["Content-Type"],
          contentType.hasPrefix("application/json") else {
        response.status(.unsupportedMediaType)
        response.send(["error":
                        "Request Content-Type must be application/json"])
        return next()
    }
    var entry: JournalEntry
    do {
        try entry = request.read(as: JournalEntry.self)
    } catch {
        response.status(.unprocessableEntity)
        if let decodingError = error as? DecodingError {
            response.send(
                "Could not decode received data: " +
                    "\(decodingError.humanReadableDescription)")
        } else {
            response.send("Could not decode received data.")
        }
        return next()
    }
    response.status(.created)
    response.send(json: entry)
    next()
}
