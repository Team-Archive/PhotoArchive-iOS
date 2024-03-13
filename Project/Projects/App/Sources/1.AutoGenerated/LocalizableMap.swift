// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum InfoPlist {
    /// About Time
    internal static let cfBundleDisplayName = L10n.tr("InfoPlist", "CFBundleDisplayName")
    /// 위젯에 등록할 사진을 찍기위해 필요합니다.
    internal static let nsCameraUsageDescription = L10n.tr("InfoPlist", "NSCameraUsageDescription")
  }
  internal enum Localizable {
    /// 예상하지 못한 오류가 발생하였습니다.
    internal static let commonErrorMessage = L10n.tr("Localizable", "Common_Error_Message")
    /// 오류
    internal static let commonErrorTitle = L10n.tr("Localizable", "Common_Error_Title")
    /// 네트워크오류
    internal static let commonErrorTitleFromNetwork = L10n.tr("Localizable", "Common_Error_Title_From_Network")
    /// 서버오류
    internal static let commonErrorTitleFromServer = L10n.tr("Localizable", "Common_Error_Title_From_Server")
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
