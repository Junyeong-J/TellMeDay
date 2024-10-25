![iOS 16.0](https://img.shields.io/badge/iOS-16.0-lightgrey?style=flat&color=181717)
[![Swift 5.10](https://img.shields.io/badge/Swift-5.10-F05138.svg?style=flat&color=F05138)](https://swift.org/download/) [![Xcode 15.3](https://img.shields.io/badge/Xcode-15.3-147EFB.svg?style=flat&color=147EFB)](https://apps.apple.com/kr/app/xcode/id497799835?mt=12)

# 수다일기
<img src="https://github.com/user-attachments/assets/a9f84051-4c52-41a7-a676-6a458d36c98d" alt="myAppIcon" width="200"/>

[![App Store](https://img.shields.io/badge/App%20Store-Download-blue?style=for-the-badge&logo=apple&logoColor=white)](https://apps.apple.com/kr/app/%EC%88%98%EB%8B%A4%EC%9D%BC%EA%B8%B0/id6720724099)


## 프로젝트 소개
수다일기는 음성으로 일기를 작성하고 감정을 분석해주는 음성 일기 앱입니다.
자신의 목소리로 일기를 기록할 수 있으며, 자동으로 감정 분석을 통해 다양한 감정을 시각적으로 표현합니다.
- 진행 기간
    - 기획 : 2024.09.11 ~ 2024.09.14
    - 개발 : 2024.09.15 ~ 2024.10.01
    - 출시 : 2024.10.02
- 기술 스택
    - 개발 환경 
       - iOS : Swift 5.10, Xcode 15.3
       - 서버 : GPT API 사용
    - 라이브러리 
       - iOS : SwiftUI, FSCalendar, Kingfisher, Realm, SnapKit, AVFoundation, URLSession
    - Deployment Target : iOS 16.0

## 주요 키워드
- Realm: 로컬 데이터베이스로 일기와 감정 데이터를 저장하고 조회.
- SwiftUI: UI 구성.
- UICollectionView & DiffableDataSource: 날짜별 일기 관리 및 데이터 동기화 최적화.
- CALayer: 감정 트래킹에서 잎사귀의 시각적 표현을 위해 커스텀 뷰 및 레이어를 사용.
- MVVM 패턴: 데이터와 뷰를 효율적으로 관리하기 위해 ViewModel과 Repository를 사용.
- SpeechRecognizer: 음성 텍스트 변환 기능 구현.
- AVFoundation: 음성 녹음 기능 및 파일 저장 관리.
- FileManager: 녹음 파일 관리.
- TextEditor: 일기 편집 및 실시간 텍스트 표시.
- API통신 (URLSession): 감정 분석 API 연결.
- NSRegularExpression: API 응답 데이터 파싱에 사용.
- Charts: SwiftUI 라이브러리를 활용한 감정 분석 결과 시각화.

<!--
## 파일 디렉토리 구조
```
TellMeDay
  ├── Info
  ├── Source
  │   ├── App
  │   │   └── TellMeDayApp.swift
  │   ├── Network
  │   │   └── AnalyzeSentimentNetwork.swift
  │   ├── DataBase
  │   │   ├── RealmModel.swift
  │   │   └── DiaryTableRepository.swift
  │   ├── Constants
  │   │   └── Enums
  │   │       ├── IconImageName.swift
  │   │       └── Enum.swift
  │   ├── Base
  │   │   ├── BaseView.swift
  │   │   └── BaseViewController.swift
  │   ├── Utilities
  │   │   ├── FormatterManager.swift
  │   │   ├── SpeechRecognizer.swift
  │   │   ├── AudioRecorderManager.swift
  │   │   └── EmotionImageManager.swift
  │   ├── CustomModifier
  │   │   ├── RecodingView
  │   │   │   ├── DateRecodingView.swift
  │   │   │   └── CategoriesView.swift
  │   │   ├── CalendarView
  │   │   │   └── DateHeaderView.swift
  │   │   ├── TabView
  │   │   │   └── TabIconView.swift
  │   │   ├── Protocol
  │   │   │   └── ViewModelType.swift
  │   │   └── Wrappers
  │   │       └── ForegroundWrapper.swift
  ├── Views
  │   ├── AnalyzeView
  │   ├── TabBar
  │   │   ├── CustomTabView.swift
  │   │   └── CircleButtonView.swift
  │   ├── MyDiaryView
  │   │   ├── MyDiaryView.swift
  │   │   └── DiaryCardView.swift
  │   ├── EditDiaryView
  │   │   └── EditDiary.swift
  │   ├── DetailRecordingView
  │   │   └── DiaryDetailView.swift
  │   ├── MainView
  │   │   └── MainView.swift
  │   ├── RecodeView
  │   │   ├── RecodeView.swift
  │   │   ├── TitleTextField.swift
  │   │   └── VoiceDiaryRecordingView.swift
  │   └── ResultView
  ├── ViewModel
  │   ├── CalendarViewModel.swift
  │   ├── RecodeViewModel.swift
  │   ├── VoiceDiaryRecordingViewModel.swift
  │   └── EditDiaryViewModel.swift
  ├── Controller
  │   ├── MonthCalendarViewController.swift
  │   └── Cell
  │       └── MonthCalendarView.swift
  ├── Resource
  │   ├── Assets
  │   └── Fonts
  │       ├── ResourceFonts.swift
  │       └── 나눔손글씨 규리의 일기
  └── Preview Content
      ├── Preview Assets
      └── APIKey.swift
```
-->

## 📱 주요 화면

> 🗓️ **메인 화면**, 🌳 **감정 트래킹**, 🌙 **다크 모드**

<img src="https://github.com/user-attachments/assets/decabeed-7ac2-46f6-8fee-81a6d7cd3370" width="200"> <img src="https://github.com/user-attachments/assets/b683accc-94ae-48f6-91aa-3800f144d113" width="200"> <img src="https://github.com/user-attachments/assets/ec9a8918-f447-4a0b-a177-2c1479e08693" width="200">

---

> 📚 **내 일기 모음집** 및 🔍 **저장된 일기 상세 보기**

<img src="https://github.com/user-attachments/assets/545e0a36-c164-4dc3-b2f7-26f3f0e2552f" width="200"> <img src="https://github.com/user-attachments/assets/f13e7598-00e2-429f-8956-bcd43418c3d1" width="200">

---

> 📝 **일기 작성 (제목 입력)** 및 🎤 **일기 작성 (음성 녹음)**

<img src="https://github.com/user-attachments/assets/ae34c7c8-1fba-40b1-8c9c-3646a356ede2" width="200"> <img src="https://github.com/user-attachments/assets/a7a9cc1e-0c9b-4b12-92ac-23778a25eabf" width="200">

---

> 📊 **분석 결과**

<img src="https://github.com/user-attachments/assets/6ff69a96-3e0c-401a-a668-c7c9f852691c" width="200">


## 1️⃣ STEP1. 텝바화면 (메인, 감정트래킹, 내 일기 모음집)
### 1-1 주요기능

- 메인화면
    - 선택한 날짜에 작성된 일기를 조회하거나 새 일기를 작성할 수 있는 기능을 제공.
    - **MonthCalendarViewControllerWrapper**는 UIKit의 UICollectionView와 DiffableDataSource를 활용해 날짜별 일기를 관리합니다,
      데이터 업데이트 시 발생하는 복잡한 동기화를 해결하기 위해 DiffableDataSource를 도입하여, 데이터의 일관성을 유지하고 UI 업데이트의 성능을 최적화.
    - 날짜별로 일기 데이터를 캐싱하여, 반복적인 데이터 요청 없이 빠르게 화면을 렌더링. 캐싱된 데이터는 날짜가 선택될 때마다 적재되며, Realm에서 조회된 데이터는 비동기적으로 업데이트됩니다.
- 감정 트래킹
    - 사용자 감정을 시각적으로 트래킹하는 기능. 감정 분석 결과는 나무의 잎사귀 색상으로 표현되며, LeafShape는 SwiftUI의 Shape 프로토콜을 준수하여 벡터 그래픽으로 감정 상태를 시각화합니다.
    - 잎사귀의 색상은 AI 감정 분석 API를 통해 반환된 감정 데이터를 기반으로 동적으로 변경되며, 각 잎사귀는 감정에 따라 위치가 달라집니다. 이때, CALayer를 사용해 레이어별로 성능 최적화를 구현했습니다.
- 내 일기 모음집:
    - 사용자가 작성한 일기 데이터를 Realm에서 불러와 날짜별로 정렬하여 표시합니다.
    - DiaryCardView는 LazyVStack을 사용해 성능을 최적화하며, 대량의 일기 데이터를 스크롤할 때 부드럽게 렌더링됩니다.
    - FetchRequest는 비동기적으로 이루어지며, 데이터 로딩 중에도 사용자 경험을 유지하기 위해, Combine을 활용해 데이터 흐름을 제어했습니다.

### 1-2 고민한점
1. 잎사귀의 모양과 시각적 표현의 최적화
    - 감정 트래킹 화면에서 감정 데이터를 어떻게 효과적으로 시각화할지 고민했습니다. 처음에는 사진을 사용할지 고려했지만, SwiftUI의 Shape 프로토콜을 활용해 커스텀 LeafShape를 구현할 수 있다는 것을 알게 되었습니다.
      이를 통해 Bezier 곡선을 사용하여 부드러운 곡선의 잎사귀 모양을 그렸으며, 감정의 강도에 따라 잎사귀의 크기와 모양이 다르게 변하도록 설정했습니다.
2. 탭바 커스터마이징과 동적 높이 조정
   - 다양한 화면 크기와 기기에 대응하기 위해 탭바의 높이를 동적으로 조정하는 부분에 중점을 두었습니다.
   - iPhone 15 Pro와 iPhone SE와 같은 다양한 화면 크기에서 일관된 UI 경험을 제공하기 위해, GeometryReader를 사용해 탭바의 레이아웃을 디바이스의 화면 크기에 맞게 자동 조정하도록 구현했습니다.
     이로 인해 탭 전환 시 화면이 부드럽게 전환되면서도 다양한 기기에서 일관된 사용자 경험을 제공할 수 있었습니다.
     
### 1-3 트러블슈팅
1. 일기 삭제시 앱이 충돌하는 문제
- 일기를 삭제 후 View가 제대로 갱신되지 않거나 크래시하는 문제가 발생했습니다. 삭제된 일기에 연결된 데이터를 처리하는 과정에서 문제가 발생한것 같았고 앱이 강제 종료 되었습니다.
2. 해결과정
- 일기 삭제한 후에도 View에서 여전히 삭제된 DiaryEntry객체에 접근하려고 시도했기 때문에 발생한 것이었습니다.
  그 객체가 더 이상 존재하지 않기 때문에 앱이 충돌하게 된다고 생각했습니다.
  이를 해결하기 위해 deleteEntry() 메서드에서 entry = DiaryEntry()로 초기화하여 삭제된 일기에 대한 참조를 즉시 제거했습니다.
  ~~~swift
  
    func deleteEntry() {
        if let audioFileName = entry.audioFilePath {
            let fullPath = getFullAudioPath(for: audioFileName)
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: fullPath) {
                do {
                    try fileManager.removeItem(atPath: fullPath)
                    print("녹음 파일 삭제 완료")
                } catch {
                    print("녹음 파일 삭제 실패: \(error)")
                }
            }
        }
        repository.deleteEntryAndFolderIfNeeded(entry)
        // 삭제 후 빈 DiaryEntry로 바로 초기화 했습니다.
        entry = DiaryEntry()
        firstNaviLinkActive = false
        dismiss()
    }

  ~~~
3. 결과
   - 삭제 후에도 안전하게 View가 갱신되었습니다.

## 2️⃣ STEP2. 일기 작성 화면 및 녹음 기능(STT)
### 2-1 주요기능
- 일기 작성 및 녹음기능
    - 날짜를 선택후, STT(음성텍스트 변환)기능을 사용해 음성으로 일기를 작성할 수 있습니다.
      녹음 기능은 AVFoundation 프레임워크를 활용하여 통합되었으며, 사용자가 직접 음성을 녹음한 후 이를 파일 시스템에 저장합니다.
      녹음 파일은 앱 내부의 FileManager 경로에 저장되며, 저장된 파일은 나중에 재생 가능하거나 음성 데이터로 활용됩니다.
    - STT: SpeechRecognizer를 통해 녹음된 음성을 실시간으로 텍스트로 변환해 줍니다. 최대 500자까지 저장되도록 하였고, TextEditor를 통해
      편집된 일기의 내용을 화면에 실시간으로 표시됩니다. 음성 인식과 텍스트 변환은 AVAudioEngine을 사용해 실시간으로 처리됩니다.
      
### 2-2 고민한점
- STT기능의 정확성과 음질 최적화
    - 처음에는 STT(음성 텍스트 변환) 기능의 정확도와 음질을 어떻게 최적화할지 잘 몰랐습니다.
      음성 인식에서 발생하는 오류와 정확도 문제를 해결하기 위해 SpeechRecognizer의 언어 설정을 사용자의 디바이스에 맞춰 동적으로 변경했고, 음성 인식 결과가 실시간으로 반영되도록 개선했습니다.
    - 또한, 대부분의 오디오 소프트웨어는 32kHz, 24kHz, 16kHz 또는 12kHz를 사용한다는 것을 찾았습니다. 그 이상은 CD 오디오의 표준이라고 하여
      한번 음성 파일의 크기와 음질 사이의 균형을 맞추기 위해 다양한 샘플 레이트로 테스트를 진행했습니다.
      8kHz 부터 실험한 결과 12kHz에부터 충분히 사용자들이 알아듣기 쉬운 음질을 제공했습니다.(용량 크기도 고려)
      
### 2-3 트러블슈팅
1. 녹음 시간 초과시 STT기능 중단 안되는 현상
    - 음성 녹음 기능이 최대 3분으로 제한되어있지만, 3분이 지나도 STT는 계속 실행되고 있었습니다. 즉 백그라운드에서 음성인식은 진행되고 있었습니다.
2. 해결과정
    - 문제를 해결하기위해 먼저 STT와 녹음이 어떻게 동기화 되는지 확인했습니다.
      처음에는 stopTranscribing() 메서드에서 audioEngine과 recognitionTask를 중단하기 위해 audioEngine.stop(),
      recognitionRequest?.endAudio(), recognitionTask?.cancel()을 호출했지만, 이 방법만으로는 STT가 완전히 종료되지 않았습니다.
      STT의 일부 리소스가 여전히 할당된 상태로 남아 있어, STT 기능이 계속 동작하고 있었습니다.
      이를 해결하기 위해 recognitionRequest와 recognitionTask를 nil로 설정하고 나서야 STT 기능이 완전히 중단되었습니다.
   ~~~swift

    func stopTranscribing() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recognitionTask?.cancel()
        }
    
        accumulatedTranscript = transcript
    
        recognitionRequest = nil
        recognitionTask = nil
    }
    
   ~~~
3. 결과
    - 3분이 지날시 음성 녹음 및 STT 기능이 동시에 종료되었습니다.

## 3️⃣ STEP3. 분석 화면 (API 연결)
### 3-1 주요기능
- 사용자가 음성으로 일기를 작성하고 저장할 때, 해당 일기의 텍스트 데이터를 기반으로 감정 분석 API를 호출합니다.
  감정 분석 API는 텍스트에서 긍정과 부정의 비율을 산출한 후, 이를 통해 기쁨, 슬픔, 분노, 공포 4개의 주요 감정 중 하나로 도출하는 방식으로 작동합니다.
  
### 3-2 고민한점
- 감정 데이터 시각화
    - 감정 분석 결과를 어떻게 표현할지 고민이 많았습니다. 처음에는 단순히 텍스트로 표시할까 생각했으나
      SwiftUI의 Charts라이브러리를 활용해보면 좋을거 같아 이 방식을 채택했습니다.
      이를 통해 사용자는 감정 분석 결과를 시각적으로 한눈에 확인이 가능해 쉽게 더 이해할 수 있는 수치라고 생각했습니다.
      
### 3-3 트러블슈팅
1. API호출 결과 파싱문제
   - 처음에는 감정 분석을 위해 API를 호출했을 때, 응답이 내가 원하는 구조화된 데이터가 아니라, 단순히 "이 글은 긍정이며 ~~%, 부정이며 ~~%"와 같은 서술형 문장으로 왔습니다.
     긍정과 부정의 비율을 숫자로, 감정상태도 따로 추출하고 싶었는데 어떻게 처리를 해야할지 문제가 생겼다.
2. 해결과정
   - API 응답에서 원하는 데이터를 추출하기 위해 NSRegularExpression(정규 표현식)을 사용하여 문자열을 파싱하는 방식을 도입했습니다.
   ~~~swift
    private func parseSentimentResult(_ sentimentText: String) -> [SentimentData] {
        let positiveRegex = try? NSRegularExpression(pattern: "긍정:?\\s*(\\d+)%")
        let negativeRegex = try? NSRegularExpression(pattern: "부정:?\\s*(\\d+)%")
    
        var positivePercentage: Int = 0
        var negativePercentage: Int = 0
    
        if let match = positiveRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                positivePercentage = Int(sentimentText[range]) ?? 0
            }
        }
    
        if let match = negativeRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                negativePercentage = Int(sentimentText[range]) ?? 0
            }
        }
    
        return [
            SentimentData(emotion: "긍정", percentage: Double(positivePercentage)),
            SentimentData(emotion: "부정", percentage: Double(negativePercentage))
        ]
        }
    
        private func parseEmotion(_ sentimentText: String) -> String {
        let emotionRegex = try? NSRegularExpression(pattern: "(기쁨|슬픔|공포|분노)")
    
        if let match = emotionRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                return String(sentimentText[range])
            }
        }
    
        return "분석 실패"
    }
    ~~~
3. 결과
   - 이렇게 정규 표현식을 사용하여 응답을 파싱했더니 내가원했던 긍정/부정/감정 비율 및 상태를 정확하게 추출 할 수 있었습니다. 이를 이용해서 바로 UI에 반영할 수 있었습니다.
     
