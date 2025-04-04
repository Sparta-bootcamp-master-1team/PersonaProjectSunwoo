# HarryPotterSeries
## 소개
> 앱 개발 입문주차 개인과제 HarryPotterBookSeries 소개 앱을 구현했습니다.  
> 단계별로 요구사항에 맞게 구현했습니다.  
> 구현에 필요한 데이터 파일인 data.json 파일을 추가해두었습니다.  
> Asset 파일에 harrypotter1~7 이미지 파일을 추가해두었습니다.

## 기술
- 개발환경: Xcode, iOS, App
- 언어: Swift
- 라이브러리: SnapKit

## 설명
### Lv1
- data.json 파일에 있는 데이터를 가져와서 첫 번째 값의 제목(UILabel)과 시리즈 순서(UIButton)를 표시합니다.
> ![스크린샷 2025-04-04 오후 3 11 41](https://github.com/user-attachments/assets/2a92b89e-bcbb-4dba-b73d-778edc08d0cd)

### Lv2
- 책 정보 영역을 UIStackView를 사용해서 구현합니다.
  - 책 표지의 이미지의 비율은 height : width = 1 : 1.5
  - Json에서 released 속성이 `1997-06-26`형태로 되어있는 데이터를 `June 26, 1997`형태로 변형합니다.
  - 책 정보 영역이 시리즈 순서 영역(UIButton) 하단에 위치합니다.
> ![스크린샷 2025-04-04 오후 3 35 33](https://github.com/user-attachments/assets/86ca0a40-f3e8-467a-ba66-19459c7917ae)

- Json 데이터를 가지고 오기 실패한 경우 Alert창으로 에러의 원인을 사용자에게 알립니다.
> ![스크린샷 2025-04-04 오후 3 34 05](https://github.com/user-attachments/assets/f193484f-157a-49be-80aa-e24846e91ea9)

### Lv3
- UIStackView와 UILabel을 사용해서 Dedication, Summary를 구현합니다.
> ![스크린샷 2025-04-04 오후 3 40 37](https://github.com/user-attachments/assets/f8739244-0f4c-4338-95f5-f814ae1de2b2)

### Lv4
- 책 제목(UILabel)과 시리즈 순서(UIButton) 하단에 UIScrollView를 구현합니다.
- Summary 하단에 Chapters를 구현합니다.
  - UIScrollView 안에 UIStackView 안에 UILabel이 들어있는 구조
> ![Simulator Screen Recording - iPhone 16 Pro - 2025-04-04 at 15 46 30](https://github.com/user-attachments/assets/f298812b-cc66-4dc6-96a0-da889307845d)

### Lv5
- Summary의 내용 글자 수가 450자 이상인 경우 `...`말줄임표 표시와 `더 보기`버튼 표시합니다.
  - 2권은 Summary의 글자 수가 450자 미만이므로 `더 보기`버튼이 표시되지 않습니다.
- `더 보기`버튼을 누르면 요약된 내용에서 전체 내용이 표시되고 `더 보기`버튼은 `접기`버튼으로 변경됩니다.
- `더 보기`/`접기` 상태를 저장해 앱을 종료하거나 다시 실행했을 때도 마지막 상태를 기억해서 표시합니다.
> ![Simulator Screen Recording - iPhone 16 Pro - 2025-04-04 at 15 56 42](https://github.com/user-attachments/assets/2908b91b-ff9d-4c85-85b5-7503fc17fc5a)

### Lv6
- 시리즈 순서 버튼(1~7)을 누르면 화면 상단에 있는 책 제목 / 책 정보 영역의 책표지 이미지, Author, Released, Pages / 책 소개 영역의 Dedication, Summary, Chapters 데이터가 업데이트 됩니다.
- 시리즈 권별로 `더 보기`/`접기` 상태를 저장하는 기능을 구현하여, 각 시리즈 권별로 마지막 `더 보기`/`접기`상태를 기억합니다.
> ![Simulator Screen Recording - iPhone 16 Pro - 2025-04-04 at 16 03 31](https://github.com/user-attachments/assets/83cc37c1-db84-476d-9588-40c0436872ee)

### Lv7
- iOS 16.0과 호환 가능한 iPhone 모델의 다양한 디바이스 지원과 `Portrait`/`Landscape`모드를 대응하여 구현합니다.
- 콘텐츠가 노치나 다이나믹 아일랜드 영역에 가려지지 않도록 구현합니다.
> ![Simulator Screen Recording - iPhone 16 Pro - 2025-04-04 at 16 08 21](https://github.com/user-attachments/assets/c8abe19e-1d1f-43c3-a50f-3607e99d405c)
> ![Simulator Screen Recording - iPhone SE (3rd generation) - 2025-04-04 at 16 12 09](https://github.com/user-attachments/assets/af45aa3e-db08-4120-b97f-b9ec54b26fd8)


## 프로젝트 구조
```
HarryPotterSeries
├── AppDelegate.swift
├── Controllers
│   └── ViewController.swift
├── Info.plist
├── Models
│   └── BookResponse.swift
├── SceneDelegate.swift
├── Services
│   └── DataService.swift
├── Views
│   ├── SeriesBookChaptersView.swift
│   ├── SeriesHeaderView.swift
│   ├── SeriesInformationView.swift
│   └── SeriesIntroduceView.swift
└── data.json
```
