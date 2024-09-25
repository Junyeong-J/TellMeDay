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

extension RecodingViewModel {
    
    struct Input {
        var selectedDate = Date()
        var selectedCategory: String = "카테고리 선택"
        var customCategory: String = ""
        let skipButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var selectedDate: String = ""
        var selectedCategory: String = "카테고리 선택"
        var customCategoryVisible: Bool = false
        var isSkipTitle: Bool = false
        var title: String = ""
    }
    
    func transform() {
        output.selectedDate = FormatterManager.shared.recodingDateHeader(input.selectedDate)
        output.selectedCategory = input.selectedCategory
        output.customCategoryVisible = input.selectedCategory == "기타"
        output.title = output.isSkipTitle ? "제목 없음" : output.title
    }
    
    func updateCategory(_ category: String) {
        input.selectedCategory = category
        if category != "기타" {
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
        output.title = output.isSkipTitle ? "제목 없음" : output.title
    }
    
}

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
