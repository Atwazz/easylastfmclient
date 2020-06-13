//
//  TrackViewModelFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct TrackViewModelFactoryBase { }

// MARK: - TrackViewModelFactory
extension TrackViewModelFactoryBase: TrackViewModelFactory {
    func vieModel(entity: TrackEntity) -> TrackViewModel {
        guard let name = entity.name else {
            fatalError("TrackEntity has invalid state!")
        }
        return TrackViewModel(name: name,
                              url: entity.url,
                              rank: String(entity.rank),
                              duration: entity.duration.formattedDurationString)
    }
    
    func viewModel(track: Track) -> TrackViewModel {
        TrackViewModel(name: track.name,
                       url: track.url,
                       rank: String(track.rank),
                       duration: track.duration.formattedDurationString)
    }
}

// MARK: - Private: FixedWidthInteger + FormattedString
private extension FixedWidthInteger {
    var formattedDurationString: String {
        Time(seconds: UInt32(self)).formattedString()
    }
}
