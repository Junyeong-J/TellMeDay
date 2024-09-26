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
    @Published var audioRecorderManager = AudioRecorderManager()
    
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
        var playShow: Bool = true
        var isPlaying: Bool = false
        var isRecording: Bool = false
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
            if !output.isRecording{
                output.isRecording = true
                audioRecorderManager.startRecording()
            } else {
                audioRecorderManager.resumeRecording()
            }
            output.isPlaying = true
            output.showStopButton = true
            startTimer()
            speechRecognizer.startTranscribing()
        } else {
            output.isPlaying = false
            output.showStopButton = true
            stopTimer()
            speechRecognizer.stopTranscribing()
            audioRecorderManager.pauseRecording()
        }
    }
    
    private func handleStop() {
        output.isPlaying = false
        output.showStopButton = false
        output.playShow = false
        output.listenButton = true
        output.isRecording = false
        stopTimer()
        speechRecognizer.stopTranscribing()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
        } catch {
            print("오디오 세션 재설정 오류: \(error.localizedDescription)")
        }
        
        audioRecorderManager.stopRecording()
    }
    
    private func toggleListen() {
        if let recordingURL = audioRecorderManager.currentRecordingURL {
            if audioRecorderManager.isPlaying && audioRecorderManager.audioPlayer?.url == recordingURL {
                if audioRecorderManager.isPaused {
                    audioRecorderManager.resumePlaying()
                    output.isPlaying = true
                    startPlaybackTimer()
                } else {
                    audioRecorderManager.pausePlaying()
                    output.isPlaying = false
                    stopTimer()
                }
            } else {
                audioRecorderManager.startPlaying()
                output.isPlaying = true
                startPlaybackTimer()
            }
        } else {
            print("재생할 녹음 파일이 없습니다.")
        }
    }
    
    private func startPlaybackTimer() {
        stopTimer()
        guard let audioPlayer = audioRecorderManager.audioPlayer else { return }
        let totalDuration = Int(audioPlayer.duration)
        var currentTime = 0
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                currentTime += 1
                self.output.timerText = self.formattedTime(currentTime)
                
                if currentTime >= totalDuration {
                    self.stopTimer()
                    self.output.isPlaying = false
                }
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
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
