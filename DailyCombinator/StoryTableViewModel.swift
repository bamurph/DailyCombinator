//
//  StoryTableViewModel.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/12/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result
import Firebase

class StoryTableViewModel {

    let newsService = HNService()
    let topStories = MutableProperty<[NSDictionary]>([])


    // Inputs
    let active = MutableProperty(false)
    let refreshObserver: Observer<Void, NoError>

    // Outputs

    // Actions

    init() {

        let (refreshSignal, refreshObserver) = Signal<Void, NoError>.pipe()
        self.refreshObserver = refreshObserver

        let topStoriesSubscriber = Observer<Void, NoError>(value: { self.fetchTopStories(refreshSignal: refreshSignal, count: 15)
        })
        refreshSignal.observe(topStoriesSubscriber)
        refreshObserver.send(value: ())
    }

    func fetchTopStories(refreshSignal: Signal<Void, NoError>, count: Int) {
        SignalProducer(signal: refreshSignal)
            .startWithValues {
                self.newsService.storyIDs(type: .top)
                    .on(value: { ids in
                        let newTopStories = MutableProperty<[NSDictionary]>([])
                        self.newsService.signalForItems(ids: ids)
                            .take(first: count)
                            .startWithSignal { (observer, disposable) -> () in
                                observer.observeValues({ dict in
                                    print(dict)
                                    newTopStories.value.append(dict)
                                })

                                observer.observeCompleted {
                                    print("Completed!")
                                    self.topStories.value = newTopStories.value

                                }
                        }
                    })

                    .start()
        }

    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfStoriesInSection(section: Int) -> Int {
        return topStories.value.count
    }

    func storyAtIndexPath(indexPath: IndexPath) -> NSDictionary {
        return topStories.value[indexPath.row]
    }

    func storyTitleAtIndexPath(indexPath: IndexPath) -> String {
        return storyAtIndexPath(indexPath: indexPath).value(forKey: "title") as? String ?? ""
    }
}
