//
//  TellMeDayApp.swift
//  TellMeDay
//
//  Created by 전준영 on 9/10/24.
//

import SwiftUI
import RealmSwift

@main
struct TellMeDayApp: App {
    
    init() {
        configureRealmMigration()
    }
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
        }
    }

    private func configureRealmMigration() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: DiaryEntry.className()) { oldObject, newObject in
                        guard let oldEmotion = oldObject?["emotion"] as? String else { return }

                        let migratedEmotion: String
                        switch oldEmotion {
                        case "기쁨": migratedEmotion = "joy"
                        case "슬픔": migratedEmotion = "sadness"
                        case "분노": migratedEmotion = "anger"
                        case "공포": migratedEmotion = "fear"
                        default: migratedEmotion = oldEmotion
                        }

                        newObject?["emotion"] = migratedEmotion
                    }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config
    }
}
