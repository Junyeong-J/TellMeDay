//
//  EditDiaryViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import Foundation
import Combine

final class EditDiaryViewModel: ViewModelType {
    
    private var repository = ListTableRepository()
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
    
    func updateCategory(_ category: String, entry: DiaryEntry) {
        repository.updateCategory(category, for: entry)
        if category == StringData.Category.etc {
            output.customCategoryVisible = true
        } else {
            output.customCategoryVisible = false
        }
    }
    
    func updateTitle(_ title: String) {
        output.title = title
    }
    
    func updateEntry(_ entry: DiaryEntry, completion: @escaping () -> Void) {
        let finalCategory: String
        if input.selectedCategory == StringData.Category.etc, input.customCategory.isEmpty {
            finalCategory = StringData.Category.etc
        } else if input.selectedCategory == StringData.Category.etc {
            finalCategory = input.customCategory
        } else {
            finalCategory = input.selectedCategory
        }
        
        repository.updateEntry(entry, newTitle: output.title, newCategory: finalCategory)
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func toggleSkipTitle() {
        output.isSkipTitle.toggle()
        if output.isSkipTitle {
            output.title = NSLocalizedString("제목 없음", comment: "")
        } else {
            output.title = ""
        }
    }
}

extension EditDiaryViewModel {
    
    struct Input {
        var selectedDate: Date = Date()
        var selectedCategory: String = ""
        var customCategory: String = ""
        var skipButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var selectedDate: String = ""
        var customCategoryVisible: Bool = false
        var title: String = ""
        var isSkipTitle: Bool = false
    }
    
    func transform() {
        output.selectedDate = FormatterManager.shared.recodingDateHeader(input.selectedDate)
        
        input.skipButtonTapped
            .sink { [weak self] _ in
                self?.toggleSkipTitle()
            }
            .store(in: &cancellables)
    }
}

extension EditDiaryViewModel {
    
    enum Action {
        case isSkipTitle
    }
    
    func action(_ action: Action) {
        switch action {
        case .isSkipTitle:
            input.skipButtonTapped.send(())
        }
    }
    
}
