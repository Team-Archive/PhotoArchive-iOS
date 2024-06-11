# AbountTime-iOS

## Project Management
 - 이 프로젝트는 [Tuist](https://github.com/tuist/tuist) 버전[3.39.0](https://github.com/tuist/tuist/releases/tag/3.39.0)기반으로 관리되고 있습니다.
 - 프로젝트 진행사항 관리는 깃허브 [프로젝트](https://github.com/orgs/Team-Archive/projects/3)를 사용하고 있습니다.

## Commit Message
커밋메시지앞에 주제를 붙혀주세요
 - **feat**: 새로운 기능 추가
 - **fix**: 버그 수정
 - **docs**: 문서 수정
 - **style**: 코드 스타일 변경 (코드 포매팅, 세미콜론 누락 등)
 - **design**: 사용자 UI 디자인 변경
 - **test**: 테스트 코드, 리팩토링 (Test Code)
 - **refactor**: 리팩토링 (Production Code)
 - **build**: 빌드 파일 수정
 - **ci**: CI 설정 파일 수정
 - **perf**: 성능 개선
 - **chore**: 자잘한 수정이나 빌드 업데이트
 - **rename**: 파일 혹은 폴더명을 수정만 한 경우
 - **remove**: 파일을 삭제만 한 경우
> ex) `feat: 좋아요 버튼을 누를 때 햅틱 피드백 추가`

## Git Branch Strategy
[깃 플로우](https://techblog.woowahan.com/2553/)와 [깃허브 플로우](https://docs.github.com/ko/get-started/using-github/github-flow)를 적절히 사용합니다.

## Code Convention Management
 - 코드 컨벤션은 SwiftLint로 관리됩니다.
 - Indent Width는 2를 사용합니다.
#### How to Set Indent With
Xcode -> Settings -> Text Editing -> Indentation -> Indent Width

## Localization
 - 다국어 처리는 [프로그램](https://github.com/HanweeeeLee/LocalizationGen)을 이용해 자동화하여 관리하고 있습니다. 
## Major Dependency
 - SwiftUI
 - Combine
 - [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)
  
## Package Dependency Structure
![AboutTimeStruct drawio](https://github.com/Team-Archive/AboutTime-iOS/assets/60125719/7458ea3e-37a0-4dc0-a226-8d1a79431fc9)
## Package Description
> 패키지들은 각자의 샘플 프로젝트와 유닛테스트를 소유하고있습니다.
### App
실제 앱 프로젝트입니다. 아래의 패키지들을 조립해서 만들고 있습니다.

### ArchiveFoundation
앱의 기반이 되는 코드들을 포함합니다.  
이 패키지에 포함되는 코드들은 이 프로젝트 어디에서나 사용될 수 있습니다.  
변경사항이 적을 것으로 예상되는 코드들을 포함하고 있어야 합니다.

### UIComponents
UI에 관련된 코드들이 들어있습니다.

### Domain
도메인 레이어의 코드들이 들어있습니다.  
프로젝트가 커질 경우 Domain을 루트 디렉토리로 하여, Usecase 혹은 Entity별 패키지를 가져야 할 것 같습니다.

### Feature/*
각각의 기능들을 담당하고 있는 패키지입니다. View와 ViewModel을 포함하고 있습니다.  
Domain, UIComponents, ImageLoader 패키지를 적절히 사용해 구현합니다.

### Data
실제 데이터를 호출하는 코드를 포함하고 있습니다.

### AppRoute
화면 간의 의존성을 제거하기 위해 코디네이터 패턴을 사용해 화면들을 관리합니다.  
앱 패키지 내에서 플로우 코드를 작성해 어떤 화면이든 적절히 사용자에게 보여줄 수 있습니다.
 
## Collaboration Tools
 - Github
 - Notion
 - Figma
 - Google Meet
 
## License

PhotoArchive-iOS is released under the MIT license. [See LICENSE](https://github.com/Team-Archive/PhotoArchive-iOS/blob/master/LICENSE) for details.
