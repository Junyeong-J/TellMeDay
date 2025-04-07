//
//  AudioRecorderManager.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import Foundation
import AVFoundation

class AudioRecorderManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    
    var currentRecordingURL: URL?
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
        } catch {
            print("오디오 세션 설정 오류: \(error.localizedDescription)")
        }
        
        let fileURL = getDocumentsDirectory().appendingPathComponent("recording-\(Date().timeIntervalSince1970).m4a")
        currentRecordingURL = fileURL
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            print("녹음 시작: \(fileURL.path)")
            audioRecorder?.record()
            self.isRecording = true
        } catch {
            print("녹음 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    func pauseRecording() {
        audioRecorder?.pause()
        self.isRecording = false
    }
    
    func resumeRecording() {
        print("Aaa")
        audioRecorder?.record()
        self.isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        
        if let recordedURL = audioRecorder?.url {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: recordedURL.path) {
                let fileSize = try? fileManager.attributesOfItem(atPath: recordedURL.path)[.size] as? Int64
                print("녹음된 파일 경로: \(recordedURL.path), 크기: \(fileSize ?? 0) 바이트")
            } else {
                print("녹음된 파일이 존재하지 않음.")
            }
        }
        
        self.isRecording = false
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension AudioRecorderManager {
    
    func startPlaying(with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("File does not exist at path: \(url.path)")
            return
        }
        
        currentRecordingURL = url
        startPlaying()
    }
    
    
    
    func startPlaying() {
        guard let recordingURL = currentRecordingURL else {
            print("재생할 녹음 파일이 없습니다.")
            return
        }
        
        print("recordingURL: \(recordingURL)")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            self.isPlaying = true
            self.isPaused = false
            print("녹음 파일 재생 시작: \(recordingURL.path)")
        } catch {
            print("재생 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        self.isPaused = true
    }
    
    func resumePlaying() {
        audioPlayer?.play()
        self.isPaused = false
    }
    
    func stopPlaying() {
        audioPlayer?.stop()
        self.isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.isPaused = false
    }
    
    func loadAudioFile(with filePath: String) {
        let url = getDocumentsDirectory().appendingPathComponent(filePath)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("File does not exist at path: \(url.path)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
        } catch {
            print("오디오 파일 로드 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
}

extension AVAudioPlayer {
    var currentTimeString: String {
        let minutes = Int(currentTime) / 60
        let seconds = Int(currentTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var durationString: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
