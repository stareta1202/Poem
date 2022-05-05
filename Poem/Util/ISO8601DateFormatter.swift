//
//  ISO8601DateFormatter.swift
//  Poem
//
//  Created by 이용준 on 2022/05/05.
//

import Foundation

extension ISO8601DateFormatter {
  // swift-format-ignore: NeverForceUnwrap
  public convenience init(
    _ formatOptions: Options,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!
  ) {
    self.init()
    self.formatOptions = formatOptions
    self.timeZone = timeZone
  }
}

extension Formatter {
  public static let iso8601 = ISO8601DateFormatter([
    .withInternetDateTime,
    .withFractionalSeconds,
  ])
}

extension Date {
  public var iso8601: String {
    return Formatter.iso8601.string(from: self)
  }
}

extension String {
  public var iso8601: Date? {
    return Formatter.iso8601.date(from: self)
  }
}

extension JSONDecoder.DateDecodingStrategy {
  public static let iso8601withFractionalSeconds = custom {
    let container = try $0.singleValueContainer()
    let string = try container.decode(String.self)
    if let date = Formatter.iso8601.date(from: string) {
      return date
    } else {
      throw DecodingError.dataCorruptedError(
        in: container, debugDescription: "Invalid date string: " + string)
    }
  }
}

extension JSONEncoder.DateEncodingStrategy {
  public static let iso8601withFractionalSeconds = custom {
    var container = $1.singleValueContainer()
    try container.encode(Formatter.iso8601.string(from: $0))
  }
}
