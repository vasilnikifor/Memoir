import Foundation

protocol CmsProtocol {
    var common: CmsCommonProtocol { get }
    var calendar: CmsCalendarProtocol { get }
    var rate: CmsRateProtocol { get }
    var note: CmsNoteProtocol { get }
    var home: CmsHomeProtocol { get }
}

final class Cms: CmsProtocol {
    var common: CmsCommonProtocol = CmsCommon()
    var calendar: CmsCalendarProtocol = CmsCalendar()
    var rate: CmsRateProtocol = CmsRate()
    var note: CmsNoteProtocol = CmsNote()
    var home: CmsHomeProtocol = CmsHome()
}
