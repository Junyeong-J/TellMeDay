//
//  MonthCalendarViewController.swift
//  TellMeDay
//
//  Created by 전준영 on 9/16/24.
//

import SwiftUI
import UIKit
import FSCalendar
import SnapKit
import Kingfisher

struct MonthCalendarViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MonthCalendarViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

final class MonthCalendarViewController: UIViewController {

    var calendar = FSCalendar()
    var viewModel = CalendarViewModel()
    var currentPageDate: Date?
    var monthView: UIView = UIView()
    var headerLabel: UILabel = UILabel()

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMonthView()
        settingCalendar()
        setupLayout()
    }

    func setupMonthView() {
        view.addSubview(monthView)
        monthView.addSubview(headerLabel)

        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)

        monthView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(60)
        }

        headerLabel.snp.makeConstraints { make in
            make.edges.equalTo(monthView)
        }

        currentPageDate = calendar.currentPage
        headerLabel.text = dateFormatter.string(from: currentPageDate ?? Date())
    }

    func settingCalendar() {
        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.setCurrentPage(Date(), animated: true)
        calendar.select(Date())
        
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 66
        
        calendar.today = nil
        calendar.scrollDirection = .horizontal
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .month
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.titleSelectionColor = .lightGray.withAlphaComponent(0.5)
        calendar.appearance.selectionColor = .clear
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 14)
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 12)
        calendar.weekdayHeight = 15
        calendar.placeholderType = .fillSixRows
    }
    
    private func setupLayout() {
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
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
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentPageDate = calendar.currentPage
        headerLabel.text = dateFormatter.string(from: currentPageDate ?? Date())
        calendar.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
