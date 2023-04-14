import Foundation

enum MonthRecordsDataSource {
    case header(viewModel: MonthRecordsDayHeaderViewModel)
    case note(viewModel: DayNoteRecordViewModel)
    case actions(viewModel: MonthRecordsDayActionsViewModel)
}
