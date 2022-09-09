//
//  TaskProgressBar.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class TaskProgressView: UIView {
    
    /// The color shown for the portion of the progress bar that is filled.
    var progressTintColor: UIColor = .green {
        didSet {
            progressTintView.backgroundColor = progressTintColor
        }
    }
    
    /// The color shown for the portion of the progress bar that is not filled.
    var trackTintColor: UIColor = .black {
        didSet {
            trackTintView.backgroundColor = trackTintColor
        }
    }
    
    /// ranked from 0.0 to 1.0
    var progress: CGFloat = 0.2 {
        didSet {
            if progress > 1 {progress = 1}
            setProgressTint(to: progress)
        }
    }
    
    var goal: CGFloat = 10 {
        didSet {
            progress = completed / goal
            updateCompletedPerGoalLabel()
        }
    }
    
    var completed: CGFloat = 0 {
        didSet {
            progress = completed / goal
            if completed > goal {completed = goal}
            updateCompletedPerGoalLabel()
        }
    }
    
    private var progressTintView: UIView!
    private var trackTintView: UIView!
    private var completedPerGoalLabel: UILabel!
    
    var widthProgressTintViewConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTrackTintView()
        setProgressTintView()
        setCompletedPerGoalLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setProgressTint(to newValue: CGFloat) {
        widthProgressTintViewConstraint.isActive = false
        widthProgressTintViewConstraint = progressTintView.widthAnchor.constraint(equalToConstant: self.frame.width * progress)
        widthProgressTintViewConstraint.isActive = true
    }
    
    private func setCompletedPerGoalLabel() {
        completedPerGoalLabel = UILabel()
        self.addSubview(completedPerGoalLabel)
        completedPerGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            completedPerGoalLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            completedPerGoalLabel.centerYAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        completedPerGoalLabel.text = "\(Int(completed))/\(Int(goal))"
        
    }
    
    private func updateCompletedPerGoalLabel() {
        completedPerGoalLabel.text = "\(Int(completed))/\(Int(goal))"
    }
    
    private func setTrackTintView() {
        trackTintView = UIView()
        self.addSubview(trackTintView)
        trackTintView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trackTintView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            trackTintView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trackTintView.widthAnchor.constraint(equalTo: self.widthAnchor),
            trackTintView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        trackTintView.layer.cornerRadius = self.frame.height / 5
        trackTintView.backgroundColor = trackTintColor
        trackTintView.layer.masksToBounds = true
    }
    
    private func setProgressTintView() {
        progressTintView = UIView()
        trackTintView.addSubview(progressTintView)
        progressTintView.translatesAutoresizingMaskIntoConstraints = false
        widthProgressTintViewConstraint = progressTintView.widthAnchor.constraint(equalToConstant: self.frame.width * progress)
        NSLayoutConstraint.activate([
            progressTintView.leftAnchor.constraint(equalTo: trackTintView.leftAnchor),
            progressTintView.centerYAnchor.constraint(equalTo: trackTintView.centerYAnchor),
            progressTintView.heightAnchor.constraint(equalTo: trackTintView.heightAnchor),
            widthProgressTintViewConstraint
        ])
        
        progressTintView.backgroundColor = progressTintColor
    }
    

}
