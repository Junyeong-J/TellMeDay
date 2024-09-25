//
//  MonthCalendarViewController.swift
//  TellMeDay
//
//  Created by 전준영 on 9/16/24.
//

import SwiftUI
import UIKit
import FSCalendar

struct MonthCalendarViewControllerWrapper: UIViewControllerRepresentable {
    
    @Binding var selectedDate: Date?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MonthCalendarViewController()
        vc.onDateSelected = { date in
            selectedDate = date
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

final class MonthCalendarViewController: BaseViewController<MonthCalendarView> {
    
    private var viewModel = CalendarViewModel()
    private var currentPageDate: Date?
    var onDateSelected: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingCalendar()
        setupMonthView()
        rootView.calendar.reloadData()
    }

    private func setupMonthView() {
        if let selectedDate = rootView.calendar.selectedDate {
            currentPageDate = selectedDate
        } else {
            currentPageDate = Date()
        }
        rootView.headerLabel.text = FormatterManager.shared.mainViewDateHeader().string(from: currentPageDate ?? Date())
    }
    
    private func settingCalendar() {
        rootView.calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())
        
        rootView.calendar.delegate = self
        rootView.calendar.dataSource = self
    }
}

extension MonthCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as? CalendarCell else {
            return FSCalendarCell()
        }

        guard position == .current else {
            cell.backImageView.image = nil
            cell.backImageView.alpha = 0
            return cell
        }
        
        viewModel.fetchArtwork(date) { url in
            if let url = url {
                cell.backImageView.image = url
            }
        }
        
        cell.backImageView.alpha = viewModel.isCurrentSelected(date) ? 1 : 0.5
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard monthPosition == .current else {
            return
        }
        
        viewModel.updateSelectedDate(date)
        
        if let previousSelectedDate = viewModel.previousSelectedDate,
           let previousCell = calendar.cell(for: previousSelectedDate, at: monthPosition) as? CalendarCell {
            previousCell.backImageView.alpha = 0.5
        }
        
        if let currentSelectedDate = viewModel.currentSelectedDate,
           let currentCell = calendar.cell(for: currentSelectedDate, at: monthPosition) as? CalendarCell {
            currentCell.backImageView.alpha = 1
        }
        
        onDateSelected?(date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentPageDate = calendar.currentPage
        rootView.headerLabel.text = FormatterManager.shared.mainViewDateHeader().string(from: currentPageDate ?? Date())
        calendar.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
