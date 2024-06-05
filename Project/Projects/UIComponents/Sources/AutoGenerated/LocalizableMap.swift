// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum InfoPlist {
    /// About Time
    public static let cfBundleDisplayName = L10n.tr("InfoPlist", "CFBundleDisplayName")
    /// 사진을 게시하기위해 카메라 권한이 필요합니다.
    public static let nsCameraUsageDescription = L10n.tr("InfoPlist", "NSCameraUsageDescription")
    /// 사진을 게시하기위해 사진 보관함 권한이 필요합니다.
    public static let nsPhotoLibraryUsageDescription = L10n.tr("InfoPlist", "NSPhotoLibraryUsageDescription")
  }
  public enum Localizable {
    /// 접근권한 허용
    public static let albumNotPermittedAllowButtonTitle = L10n.tr("Localizable", "Album_Not_Permitted_Allow_Button_Title")
    /// About Time을 이용해 사진을 친구들과 공유하기 위해 사진첩 접근권한이 필요해요
    public static let albumNotPermittedContents = L10n.tr("Localizable", "Album_Not_Permitted_Contents")
    /// 앱 설정에서 언제든지 변경할 수 있어요.
    public static let albumNotPermittedHelp = L10n.tr("Localizable", "Album_Not_Permitted_Help")
    /// 사진첩 접근권한 허용
    public static let albumNotPermittedTitle = L10n.tr("Localizable", "Album_Not_Permitted_Title")
    /// 업로드
    public static let albumPhotoSelectCompleteButtonTitle = L10n.tr("Localizable", "Album_Photo_Select_Complete_Button_Title")
    /// 최근
    public static let albumRecentAlbum = L10n.tr("Localizable", "Album_Recent_Album")
    /// 오후
    public static let commonAfternoon = L10n.tr("Localizable", "Common_Afternoon")
    /// 새벽
    public static let commonDawn = L10n.tr("Localizable", "Common_Dawn")
    /// 예상하지 못한 오류가 발생하였습니다.
    public static let commonErrorMessage = L10n.tr("Localizable", "Common_Error_Message")
    /// 오류
    public static let commonErrorTitle = L10n.tr("Localizable", "Common_Error_Title")
    /// 네트워크오류
    public static let commonErrorTitleFromNetwork = L10n.tr("Localizable", "Common_Error_Title_From_Network")
    /// 서버오류
    public static let commonErrorTitleFromServer = L10n.tr("Localizable", "Common_Error_Title_From_Server")
    /// 저녁
    public static let commonEvening = L10n.tr("Localizable", "Common_Evening")
    /// 오전
    public static let commonForenoon = L10n.tr("Localizable", "Common_Forenoon")
    /// 아침
    public static let commonMorning = L10n.tr("Localizable", "Common_Morning")
    /// 다음
    public static let commonNext = L10n.tr("Localizable", "Common_Next")
    /// 밤
    public static let commonNight = L10n.tr("Localizable", "Common_Night")
    /// Login with Apple
    public static let signInApple = L10n.tr("Localizable", "Sign_In_Apple")
    /// Login with Facebook
    public static let signInFacebook = L10n.tr("Localizable", "Sign_In_Facebook")
    /// Login with Google
    public static let signInGoogle = L10n.tr("Localizable", "Sign_In_Google")
    /// 회원가입
    public static let signUpNaviTitle = L10n.tr("Localizable", "Sign_Up_Navi_Title")
    /// 전체 시간 선택
    public static let signUpSetActivityTimeAllSelectTitle = L10n.tr("Localizable", "Sign_Up_Set_Activity_Time_All_Select_Title")
    /// 친구, 가족과 연락하기 편한 시간대를 현재 계신 도시 시간
    /// 기준으로 선택해 주세요.
    public static let signUpSetActivityTimeContents = L10n.tr("Localizable", "Sign_Up_Set_Activity_Time_Contents")
    /// 시작하기
    public static let signUpSetActivityTimeDoneButtonTitle = L10n.tr("Localizable", "Sign_Up_Set_Activity_Time_Done_Button_Title")
    /// %@에서 연락하기 편한
    /// 시간대와 요일을 선택해 주세요
    public static func signUpSetActivityTimeTitle(_ p1: Any) -> String {
      return L10n.tr("Localizable", "Sign_Up_Set_Activity_Time_Title", String(describing: p1))
    }
    /// 지금 계신 도시를 선택해 주세요.
    public static let signUpSetCityContents = L10n.tr("Localizable", "Sign_Up_Set_City_Contents")
    /// 도시 또는 나라 스펠링을 정확하게
    /// 입력하셨는지 확인해 보세요
    public static let signUpSetCitySearchNoResultContents = L10n.tr("Localizable", "Sign_Up_Set_City_Search_No_Result_Contents")
    /// 검색 결과가 없어요
    public static let signUpSetCitySearchNoResultTitle = L10n.tr("Localizable", "Sign_Up_Set_City_Search_No_Result_Title")
    /// 도시 검색
    public static let signUpSetCitySearchPlaceholder = L10n.tr("Localizable", "Sign_Up_Set_City_Search_Placeholder")
    /// 지금 어디에 있나요?
    public static let signUpSetCityTitle = L10n.tr("Localizable", "Sign_Up_Set_City_Title")
    /// 친구들에게 불릴 이름과 프로필 사진을 설정해 주세요
    public static let signUpSetProfileContents = L10n.tr("Localizable", "Sign_Up_Set_Profile_Contents")
    /// 중복된 이름입니다.
    public static let signUpSetProfileNicknameDuplicated = L10n.tr("Localizable", "Sign_Up_Set_Profile_Nickname_Duplicated")
    /// 24자 이내로 입력해주세요.
    public static let signUpSetProfileNicknameOverLength = L10n.tr("Localizable", "Sign_Up_Set_Profile_Nickname_Over_Length")
    /// 이름 또는 별명
    public static let signUpSetProfilePlaceholder = L10n.tr("Localizable", "Sign_Up_Set_Profile_Placeholder")
    /// 프로필을 완성해 주세요
    public static let signUpSetProfileTitle = L10n.tr("Localizable", "Sign_Up_Set_Profile_Title")
    /// 보내기
    public static let takePhotoEditCompleteButtonTitle = L10n.tr("Localizable", "Take_Photo_Edit_Complete_Button_Title")
    /// 텍스트 입력하기
    public static let takePhotoEditTextInputPlaceholder = L10n.tr("Localizable", "Take_Photo_Edit_Text_Input_Placeholder")
    /// 새로운 사진
    public static let takePhotoNaviTitle = L10n.tr("Localizable", "Take_Photo_Navi_Title")
    /// 전체
    public static let takePhotoSendToAllButtonTitle = L10n.tr("Localizable", "Take_Photo_Send_To_All_Button_Title")
    /// 내 소식 보내기
    public static let takePhotoSendToButtonTitle = L10n.tr("Localizable", "Take_Photo_Send_To_Button_Title")
    /// 보낼 사람
    public static let takePhotoSendToTitle = L10n.tr("Localizable", "Take_Photo_Send_To_Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
