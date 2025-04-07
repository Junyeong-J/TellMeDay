//
//  RecodingViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import Foundation
import Combine

final class RecodingViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input() {
        didSet {
            transform()
        }
    }
    
    @Published
    var output = Output()
    
    init() {
        setupBindings()
        transform()
    }
    
    private func setupBindings() {
        input.skipButtonTapped
            .sink { [weak self] _ in
                self?.toggleSkipTitle()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Input & Output

extension RecodingViewModel {
    
    struct Input {
        var selectedDate = Date()
        var selectedCategory: String = StringData.Common.categorySelect
        var customCategory: String = ""
        let skipButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var selectedDate: String = ""
        var selectedCategory: String = StringData.Common.categorySelect
        var customCategoryVisible: Bool = false
        var isSkipTitle: Bool = false
        var title: String = ""
        var isActionButtonEnabled: Bool = false
    }
    
    func transform() {
        output.selectedDate = FormatterManager.shared.recodingDateHeader(input.selectedDate)
        
        if input.selectedCategory == StringData.Category.etc && !input.customCategory.isEmpty {
            output.selectedCategory = input.customCategory
        } else {
            output.selectedCategory = input.selectedCategory
        }
        
        output.customCategoryVisible = input.selectedCategory == StringData.Category.etc
        output.title = output.isSkipTitle ? NSLocalizedString("제목 없음", comment: "") : output.title
        output.isActionButtonEnabled = !output.title.isEmpty && output.selectedCategory != StringData.Common.categorySelect
    }
    
    func updateCategory(_ category: String) {
        input.selectedCategory = category
        if category != StringData.Category.etc {
            input.customCategory = ""
        }
        transform()
    }
    
    func updateTitle(_ title: String) {
        output.title = title
        transform()
    }
    
    private func toggleSkipTitle() {
        output.isSkipTitle.toggle()
        output.title = output.isSkipTitle ? NSLocalizedString("제목 없음", comment: "") : ""
        transform()
    }
}

// MARK: - Action
extension RecodingViewModel {
    
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
