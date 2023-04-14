import Foundation

enum MonthRecordsDataSource {
    case header(viewModel: MonthRecordsDayHeaderViewModel)
    case note(viewModel: MonthRecordsDayNoteRecordViewModel)
    case actions(viewModel: MonthRecordsDayActionsViewModel)
}
