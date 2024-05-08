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
    /// 위젯에 등록할 사진을 찍기위해 필요합니다.
    public static let nsCameraUsageDescription = L10n.tr("InfoPlist", "NSCameraUsageDescription")
  }
  public enum Localizable {
    /// 최근
    public static let albumRecentAlbum = L10n.tr("Localizable", "Album_Recent_Album")
    /// 예상하지 못한 오류가 발생하였습니다.
    public static let commonErrorMessage = L10n.tr("Localizable", "Common_Error_Message")
    /// 오류
    public static let commonErrorTitle = L10n.tr("Localizable", "Common_Error_Title")
    /// 네트워크오류
    public static let commonErrorTitleFromNetwork = L10n.tr("Localizable", "Common_Error_Title_From_Network")
    /// 서버오류
    public static let commonErrorTitleFromServer = L10n.tr("Localizable", "Common_Error_Title_From_Server")
    /// Login with Apple
    public static let signInApple = L10n.tr("Localizable", "Sign_In_Apple")
    /// Login with Facebook
    public static let signInFacebook = L10n.tr("Localizable", "Sign_In_Facebook")
    /// Login with Google
    public static let signInGoogle = L10n.tr("Localizable", "Sign_In_Google")
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
