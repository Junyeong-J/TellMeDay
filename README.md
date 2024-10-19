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
       - iOS : SwiftUI, FSCalendar, Kingfisher, Realm, SnapKit, AVFoundation
    - Deployment Target : iOS 16.0

## 주요 기능
- **음성 일기 작성**: 음성 인식 기술을 활용하여 사용자가 자신의 목소리로 일기를 기록할 수 있습니다.
- **AI 기반 감정 분석**: 작성된 데이터를 AI가 분석하여 사용자의 감정을 시각적으로 표현해 줍니다.
- **감정 트래킹**: 다양한 감정을 색깔로 시각화하여 나무에 잎사귀로 나무를 채워나갑니다.
- **일기 관리**: 날짜별로 일기를 쉽게 관리하고, 과거 일기를 찾아볼 수 있는 UI를 제공합니다.
- **다크모드 지원**: 다크 모드를 지원합니다.

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

### 1-2 고민한점

### 1-3 트러블슈팅

### 1-4 키워드

## 2️⃣ STEP2. 일기 작성 화면
### 2-1 주요기능

### 2-2 고민한점

### 2-3 트러블슈팅

### 2-4 키워드

## 3️⃣ STEP3. 일기 녹음 기능 (STT)
### 3-1 주요기능

### 3-2 고민한점

### 3-3 트러블슈팅

### 3-4 키워드

## 4️⃣ STEP4. 분석 화면 (API 연결)
### 4-1 주요기능

### 4-2 고민한점

### 4-3 트러블슈팅

### 4-4 키워드

