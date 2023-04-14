import UIKit

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

            let records: [Record] = (day.records ?? [])
                .compactMap { record in
                    guard let record = record as? Record else { return nil }
                    guard let searchText = searchText?.trimmingCharacters(in: .whitespaces), !searchText.isEmpty else { return record }
                    guard let noteRecord = record as? NoteRecord else { return nil }

                    if noteRecord.text?.range(of: searchText, options: .caseInsensitive) != nil {
                        return noteRecord
                    } else {
                        return nil
                    }
                }

            if records.isEmpty { return }

            dataSource.append(
                makeHeader(
                    day: day,
                    mode: mode,
                    delegate: delegate
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
                                viewModel: MonthRecordsDayNoteRecordViewModel(
                                    text: noteRecord.text ?? "",
                                    time: (noteRecord.time ?? Date()).timeRepresentation,
                                    action: { [weak delegate] in delegate?.openNote(day: day, noteRecord: noteRecord)}
                                )
                            )
                        )
                    }
                }

            dataSource.append(
               makeActions(day: day, delegate: delegate)
            )
        }

        return dataSource
    }

    private func makeHeader(
        day: Day,
        mode: MonthRecordsMode,
        delegate: MonthRecordsFactoryDelegate
    ) -> MonthRecordsDataSource {
        let title: String
        switch mode {
        case .month:
            title = day.date?.dateShortRepresentation ?? ""
        case .year:
            title = day.date?.dateRepresentation ?? ""
        }

        let isRateIconVisible: Bool
        let rateIconImage: UIImage?
        let rateIconTint: UIColor?
        switch day.rate {
        case .none:
            isRateIconVisible = false
            rateIconImage = nil
            rateIconTint = nil
        case .bad:
            isRateIconVisible = true
            rateIconImage = Theme.badRateFilledImage
            rateIconTint = Theme.badRateColor
        case .average:
            isRateIconVisible = true
            rateIconImage = Theme.averageRateFilledImage
            rateIconTint = Theme.averageRateColor
        case .good:
            isRateIconVisible = true
            rateIconImage = Theme.goodRateFilledImage
            rateIconTint = Theme.goodRateColor
        }
        
        return .header(
            viewModel: MonthRecordsDayHeaderViewModel(
                title: title,
                isRateIconVisible: isRateIconVisible,
                rateIconImage: rateIconImage,
                rateIconTint: rateIconTint,
                action: { [weak delegate] in delegate?.openDayRate(day: day) }
            )
        )
    }

    private func makeActions(
        day: Day,
        delegate: MonthRecordsFactoryDelegate
    ) -> MonthRecordsDataSource {
        let rateImage: UIImage
        let rateTintColor: UIColor
        
        switch day.rate {
        case .none:
            rateImage = Theme.rateDayImage
            rateTintColor = Theme.primaryTint
        case .bad:
            rateImage = Theme.badRateFilledImage
            rateTintColor = Theme.badRateColor
        case .average:
            rateImage = Theme.averageRateFilledImage
            rateTintColor = Theme.averageRateColor
        case .good:
            rateImage = Theme.goodRateFilledImage
            rateTintColor = Theme.goodRateColor
        }

        return .actions(
            viewModel: MonthRecordsDayActionsViewModel(
                rateImage: rateImage,
                rateTintColor: rateTintColor,
                rateAction: { [weak delegate] in delegate?.openDayRate(day: day) },
                addNoteAction: { [weak delegate] in delegate?.openNote(day: day, noteRecord: nil) }
            )
        )
    }
}
