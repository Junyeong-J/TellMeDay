//
//  RealmModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import Foundation
import RealmSwift

class DiaryFolder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var category: String
    @Persisted var createdDate: Date
    @Persisted var entries: List<DiaryEntry>
    
    convenience init(category: String) {
        self.init()
        self.category = category
        self.createdDate = Date()
    }
}

class DiaryEntry: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var selectedDate: Date
    @Persisted var audioFilePath: String?
    @Persisted var positiveScore: Int?
    @Persisted var negativeScore: Int?
    @Persisted var emotion: String?

    @Persisted(originProperty: "entries") var parentFolder: LinkingObjects<DiaryFolder>
    
    convenience init(title: String, content: String?, selectedDate: Date,
                     audioFilePath: String?,positiveScore: Int?,
                     negativeScore: Int?, emotion: String?) {
        self.init()
        self.title = title
        self.content = content
        self.selectedDate = selectedDate
        self.audioFilePath = audioFilePath
        self.positiveScore = positiveScore
        self.negativeScore = negativeScore
        self.emotion = emotion
    }
}
