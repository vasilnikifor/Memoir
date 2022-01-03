import Foundation

enum MonthRecordsDataSource {
    case header(viewModel: DayHeaderViewModel)
    case note(viewModel: DayNoteRecordViewModel)
    case actions(viewModel: DayActionsViewModel)
}
