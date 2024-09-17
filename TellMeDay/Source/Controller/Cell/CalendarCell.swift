//
//  CalendarCell.swift
//  TellMeDay
//
//  Created by 전준영 on 9/16/24.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarCell: FSCalendarCell {
    
    var backImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
        
        contentView.insertSubview(backImageView, at: 0)
        backImageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.size.equalTo(minSize())
        }
        backImageView.layer.cornerRadius = minSize() / 2
    }
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backImageView.image = nil
    }
    
    func minSize() -> CGFloat {
        let width = contentView.bounds.width - 5
        let height = contentView.bounds.height - 5
        
        return (width > height) ? height : width
    }
}


