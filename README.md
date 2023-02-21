# GRIG - Github Rank In GSM

## ✨ Summary
광주소프트웨어마이스터고등학교 학생들의 Github 활동 장려 랭킹 서비스

<br>

## 🔗 Links
AppStore - https://apps.apple.com/kr/app/gri-g/id1622010590

<br>

## 📸 Screenshots
![promotion](https://user-images.githubusercontent.com/74440939/213869420-cdf6bd4e-17bb-4f43-b35e-720097a62a7c.png)

## 🤔 Experiences
- Tuist를 사용한 모듈화
- Feature(Presentation), Data, Domain의 Clean Architecture를 기반으로 한 레이어 설계
- Feature는 도메인 관점에서 분리하며 각 RIB별로 분리
- Apollo-iOS를 사용한 GraphQL API와 통신

<details>
<summary>모듈 구조</summary>

<img src="graph.png" />
</details>

<br>

## 📚 Tech Stack
- Swift
- Tuist
- RIBs
- Apollo-iOS
- RxSwift
- Clean Architecture

<br>

## 🏃‍♀️ Run Project
```bash
$ curl -Ls https://install.tuist.io | bash
$ brew install make

$ make generate
$ xed .
```

<br>

## ⭐️ Key Function
### 메인
- 학생들의 Github 활동을 랭킹으로 확인
- Github 활동, 기수를 기준으로 정렬
- 유저를 탭하여 자세한 정보 확인
  
<div>
  <img src="https://user-images.githubusercontent.com/74440939/185818903-0d091f8a-50dc-4ed7-9385-7d6f789b7eab.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/185818919-8bd9d7b1-775c-4c11-b6bb-49b1b1c11a2e.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/185818947-57d6ede7-a942-42df-8b4e-881174a169b9.png" width="150">
</div>

### 분석
- 내가 선택한 유저와 분석 지표
- 분석 결과물을 공유 가능

<img src="https://user-images.githubusercontent.com/74440939/185819283-d261e922-c9f0-4145-81d0-3e14e8574a72.png" width="150">

### 온보딩
- 유저가 앱에 처음으로 진입할 때 온보딩 화면을 통해 앱의 기능 설명

<img src="https://user-images.githubusercontent.com/74440939/213871230-186e770a-c9c2-45eb-ab19-410149703107.png">
