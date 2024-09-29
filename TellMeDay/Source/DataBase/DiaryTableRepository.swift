//
//  DiaryTableRepository.swift
//  TellMeDay
//
//  Created by 전준영 on 9/28/24.
//

import Foundation
import RealmSwift

final class ListTableRepository {
    
    private let realm = try! Realm()
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func updateCategory(_ category: String, for entry: DiaryEntry) {
        try! realm.write {
            if let parentFolder = entry.parentFolder.first {
                parentFolder.category = category
            }
        }
    }
    
    func updateEntry(_ entry: DiaryEntry, newTitle: String, newCategory: String) {
        try! realm.write {
            entry.title = newTitle
            if let parentFolder = entry.parentFolder.first {
                parentFolder.category = newCategory
            }
        }
    }
}

//MARK: - 저장
extension ListTableRepository {
    func saveFolder(category: String) -> DiaryFolder {
        let folder = DiaryFolder(category: category)
        try! realm.write {
            realm.add(folder)
        }
        return folder
    }
    
    func saveEntry(to folder: DiaryFolder, title: String, content: String?, selectedDate: Date,
                   audioFilePath: String?, positiveScore: Int?, negativeScore: Int?, emotion: String?) {
        let entry = DiaryEntry(
            title: title,
            content: content,
            selectedDate: selectedDate,
            audioFilePath: audioFilePath,
            positiveScore: positiveScore,
            negativeScore: negativeScore,
            emotion: emotion
        )
        try! realm.write {
            folder.entries.append(entry)
        }
    }
}

//MARK: - 가져오기
extension ListTableRepository {
    
    func fetchEntry(by id: ObjectId) -> DiaryEntry? {
        return realm.objects(DiaryEntry.self).filter("id == %@", id).first
    }
    
    func fetchFolder() -> [DiaryFolder] {
        let value = realm.objects(DiaryFolder.self)
        return Array(value)
    }
    
    func fetchEntry(for date: Date) -> DiaryEntry? {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return realm.objects(DiaryEntry.self)
            .filter("selectedDate >= %@ AND selectedDate < %@", startOfDay, endOfDay)
            .first
    }
    
    func fetchEntryTo(for date: Date) -> DiaryEntry? {
        let entries = realm.objects(DiaryEntry.self).filter("selectedDate == %@", date)
        return entries.first
    }
    
    func fetchEntries(for year: Int, month: Int) -> [DiaryEntry] {
        let calendar = Calendar.current
        
        var startComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startComponents)!
        
        startComponents.month = month + 1
        let endDate = calendar.date(from: startComponents)!
        
        let entries = realm.objects(DiaryEntry.self)
            .filter("selectedDate >= %@ AND selectedDate < %@", startDate, endDate)
        
        return Array(entries)
    }
    
}

//MARK: - 삭제
extension ListTableRepository {
    func deleteEntryAndFolderIfNeeded(_ entry: DiaryEntry) {
        try! realm.write {
            if let folder = entry.parentFolder.first {
                folder.entries.remove(at: folder.entries.index(of: entry)!)
                realm.delete(entry)
                if folder.entries.isEmpty {
                    realm.delete(folder)
                    print("DiaryFolder 삭제 완료")
                }
            }
        }
    }
}
