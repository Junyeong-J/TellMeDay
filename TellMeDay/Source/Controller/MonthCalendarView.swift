//
//  MonthCalendarView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/25/24.
//

import UIKit
import SnapKit
import FSCalendar

final class MonthCalendarView: BaseView {
    
    var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.setCurrentPage(Date(), animated: true)
        calendar.select(Date())
        
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.appearance.weekdayFont = UIFont(name: "NanumGyuRiEuiIrGi", size: 14)
        calendar.appearance.titleFont = UIFont(name: "NanumGyuRiEuiIrGi", size: 14)
                
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
        return calendar
    }()
    
    var monthView: UIView = UIView()
    var headerLabel: UILabel = UILabel()
    
    private let leftLine = UIView()
    private let rightLine = UIView()
    
    override func configureHierarchy() {
        [monthView, calendar].forEach { addSubview($0) }
        [leftLine, headerLabel, rightLine].forEach { monthView.addSubview($0) }
    }
    
    override func configureLayout() {
        monthView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        leftLine.snp.makeConstraints { make in
            make.leading.equalTo(monthView.snp.leading).offset(16)
            make.trailing.equalTo(headerLabel.snp.leading).offset(-8)
            make.centerY.equalTo(monthView.snp.centerY)
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.center.equalTo(monthView)
        }
        
        rightLine.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.trailing).offset(8)
            make.trailing.equalTo(monthView.snp.trailing).offset(-16)
            make.centerY.equalTo(monthView.snp.centerY)
            make.height.equalTo(1)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        monthView.backgroundColor = .appBaseBackground
        calendar.backgroundColor = .appBaseBackground
        leftLine.backgroundColor = .appGrayAndWhite
        rightLine.backgroundColor = .appGrayAndWhite
        headerLabel.font = CustomUIFont.custom(CustomFont.gyuri, 32).font()
        headerLabel.textAlignment = .center
        headerLabel.textColor = .appGrayAndWhite
        
        calendar.appearance.titleDefaultColor = .appBlackAndWhite
        calendar.appearance.weekdayFont = CustomUIFont.custom(CustomFont.gyuri, 20).font()
        calendar.appearance.titleFont = CustomUIFont.custom(CustomFont.gyuri, 16).font()
        calendar.appearance.weekdayTextColor = .appBlackAndWhite
        calendar.appearance.titleDefaultColor = .appBlackAndWhite
    }
    
}
