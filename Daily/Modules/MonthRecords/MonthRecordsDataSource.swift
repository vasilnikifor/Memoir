import Foundation

struct MonthRecordsDataSource {
    let sectionHeaderViewModel: DayHeaderViewModel
    let sectionDataSource: [MonthRecordsSectionDataSource]
}

enum MonthRecordsSectionDataSource {
    case note(viewModel: DayNoteRecordViewModel)
    case actions(viewModel: DayActionsViewModel)
}
