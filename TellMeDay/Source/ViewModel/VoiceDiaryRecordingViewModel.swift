//
//  VoiceDiaryRecordingViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import Foundation
import Combine
import Speech

final class VoiceDiaryRecordingViewModel: ViewModelType {
    
    private var timer: AnyCancellable?
    private var elapsedTime = 0
    private let speechRecognizer = SpeechRecognizer()
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
    
    deinit {
        timer?.cancel()
    }
    
}

extension VoiceDiaryRecordingViewModel {
    
    struct Input {
        var selectedDate = Date()
        let playButtonTapped = PassthroughSubject<Void, Never>()
        let stopButtonTapped = PassthroughSubject<Void, Never>()
        let listenButtonTapped = PassthroughSubject<Void, Never>()
        
    }
    
    struct Output {
        var selectedDate: String = ""
        var timerPosition: Bool = false
        var playShow: Bool = true
        var isPlaying: Bool = false
        var showStopButton: Bool = false
        var listenButton: Bool = false
        var timerText: String = "00:00"
        var transcript: String = ""
    }
    
    func transform() {
        output.selectedDate = FormatterManager.shared.recodingDateHeader(input.selectedDate)
        
        input.playButtonTapped
            .sink { [weak self] _ in
                self?.togglePlayPause()
            }
            .store(in: &cancellables)
        
        input.stopButtonTapped
            .sink { [weak self] _ in
                self?.handleStop()
            }
            .store(in: &cancellables)
        
        input.listenButtonTapped
            .sink { [weak self] _ in
                self?.toggleListen()
            }
            .store(in: &cancellables)
        
        speechRecognizer.$transcript
            .sink { [weak self] newTranscript in
                self?.output.transcript = newTranscript
            }
            .store(in: &cancellables)
        
    }
    
    private func togglePlayPause() {
        if !output.isPlaying {
            output.isPlaying = true
            output.showStopButton = true
            output.timerPosition = true
            startTimer()
            speechRecognizer.startTranscribing()
        } else {
            output.isPlaying = false
            output.showStopButton = true
            stopTimer()
            speechRecognizer.stopTranscribing()
        }
    }
    
    private func handleStop() {
        output.isPlaying = false
        output.showStopButton = false
        output.playShow = false
        output.listenButton = true
        stopTimer()
        speechRecognizer.stopTranscribing()
    }
    
    private func toggleListen() {
        output.isPlaying.toggle()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedTime += 1
                self.output.timerText = self.formattedTime(self.elapsedTime)
                
                if self.elapsedTime >= 180 {
                    self.stopTimer()
                    self.input.listenButtonTapped.send(())
                }
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func formattedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}

extension VoiceDiaryRecordingViewModel {
    
    enum Action {
        case isPlaying
        case isShowStoping
        case isListen
    }
    
    func action(_ action: Action) {
        switch action {
        case .isPlaying:
            input.playButtonTapped.send(())
        case .isShowStoping:
            input.stopButtonTapped.send(())
        case .isListen:
            input.listenButtonTapped.send(())
        }
    }
    
}
