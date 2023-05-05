//
//  TimerView.swift
//  Chess
//
//  Created by Sergiy Brotsky on 05.05.2023.
//

import Foundation
import UIKit
import SnapKit

class TimerView: UIView {
    let textTime =  UILabel()
    let isRunningIcon = UIImageView(image: UIImage(systemName: "timer"))
    var isRunning = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = UIColor(hexString: "#5F5E5E")
        layer.cornerRadius = 5
        clipsToBounds = true
        snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        textTime.text = "10:00"
        textTime.font = .boldSystemFont(ofSize: 20)
        addSubview(textTime)
        
        textTime.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        isRunningIcon.tintColor = .label
        addSubview(isRunningIcon)
        
        isRunningIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(snp.trailing).offset(-10)
            make.width.height.equalTo(20)
            
        }
    }
    
    func updateTimer(time: Int) {
        let minutes = time / 60
        let seconds = time % 60
        
        let timeString = "\(minutes):\(seconds)"
        textTime.text = timeString
    }
    
    func updateIsRunningIcon(isRunning: Bool) {
        self.isRunning = isRunning
    }
}
