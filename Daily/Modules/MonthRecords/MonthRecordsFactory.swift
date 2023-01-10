import Foundation

protocol MonthRecordsFactoryDelegate: AnyObject {
    func openDayRate(day: Day)
    func openNote(day: Day, noteRecord: NoteRecord?)
}

protocol MonthRecordsFactoryProtocol: AnyObject {
    func makeDataSource(
        searchText: String?,
        mode: MonthRecordsMode,
        days: [Day],
        delegate: MonthRecordsFactoryDelegate
    ) -> [MonthRecordsDataSource]
}

final class MonthRecordsFactory: MonthRecordsFactoryProtocol {
    func makeDataSource(
        searchText: String?,
        mode: MonthRecordsMode,
        days: [Day],
        delegate: MonthRecordsFactoryDelegate
    ) -> [MonthRecordsDataSource] {
        var dataSource: [MonthRecordsDataSource] = []

        days.forEach { day in
            guard !day.isEmpty else { return }

            let title: String
            switch mode {
            case .month:
                title = day.date?.dateShortRepresentation ?? ""
            case .year:
                title = day.date?.dateRepresentation ?? ""
            }

            let records: [Record] = (day.records ?? [])
                .compactMap { record in
                    guard let record = record as? Record else { return nil }
                    guard let searchText = searchText, !searchText.isEmpty else { return record }
                    guard let noteRecord = record as? NoteRecord else { return nil }

                    if noteRecord.text?.range(of: searchText, options: .caseInsensitive) != nil {
                        return noteRecord
                    } else {
                        return nil
                    }
                }

            dataSource.append(
                .header(
                    viewModel: DayHeaderViewModel(
                        title: title,
                        rate: day.rate,
                        action: { [weak delegate] in delegate?.openDayRate(day: day)}
                    )
                )
            )

            records
                .sorted { record1, record2 in
                    guard let record1Time = record1.time, let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .forEach { record in
                    if let noteRecord = record as? NoteRecord {
                        dataSource.append(
                            .note(
                                viewModel: DayNoteRecordViewModel(
                                    text: noteRecord.text ?? "",
                                    time: (noteRecord.time ?? Date()).timeRepresentation,
                                    action: { [weak delegate] in delegate?.openNote(day: day, noteRecord: noteRecord)}
                                )
                            )
                        )
                    }
                }

            dataSource.append(
                .actions(
                    viewModel: DayActionsViewModel(
                        rate: day.rate,
                        rateAction: { [weak delegate] in delegate?.openDayRate(day: day)},
                        addNoteAction: { [weak delegate] in delegate?.openNote(day: day, noteRecord: nil)}
                    )
                )
            )
        }

        return dataSource
    }
}
