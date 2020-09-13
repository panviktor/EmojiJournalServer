//
//  Persistence.swift
//  
//
//  Created by Viktor on 12.09.2020.
//

import Foundation
import SwiftKueryORM
import SwiftKueryPostgreSQL
import LoggerAPI


class Persistence {
    static func setUp() {
        let pool = PostgreSQLConnection.createPool(
            host: ProcessInfo.processInfo.environment["DBHOST"] ?? "localhost",
            port: 5432,
            options:
                [.databaseName("emojijournal"),
                 .userName(ProcessInfo.processInfo.environment["DBUSER"] ?? "postgres"),
                 .password(ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "nil"), ],
            poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50)
        )
        Database.default = Database(pool)
        
        do {
        try JournalEntry.createTableSync()
        } catch let error {
            // Database table already exists
            if let requestError = error as? RequestError,
               requestError.rawValue ==
                RequestError.ormQueryError.rawValue {
                Log.info(
                    "Table \(JournalEntry.tableName) already exists")
            } else {
                Log.error("Database connection error: " +
                            "\(String(describing: error))")
            } }
    }
}
