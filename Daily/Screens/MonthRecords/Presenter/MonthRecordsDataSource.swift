import Foundation

enum MonthRecordsDataSource {
    case header(viewModel: MonthRecordsHeaderViewModel)
    case note(viewModel: MonthRecordsRecordViewModel)
    case actions(viewModel: MonthRecordsFooterViewModel)
}
