# Top Repositories on Github
## Create an iOS app to display trending repositories on Github with expandable cell detail
by: [Sajjad Sarkoobi](mailto:sajjadsarkoobi@gmail.com)


## Project Features

- Pattern: MVVM + Coordinator
- Ability to add Flows
- No Story board, just xib files ( decoupled )
- Scalable Networking based Combine technology
- Core data for caching mechanism
- UserDefaults for storing settings
- Supporting Dark mode
- Scalable Application Based on its patterns
- Specific Log class
- ApiRouter with ApiParameters which is supporting all Avalable search parameters from github api



### Benefits of Coordinator
- A/B Testing
- Creating Flows without changing in each controller
- Creating as much flows we need
- Reusablity
- Controllers completely decoupled
- Better Memory management and life cycle

## Tech

This sample app written by **Swift 5** in XCode Version **14.1 (14B47b)**

## Installation
Two third parties are used by the Swift package manager:
- Kingfisher
- Lottie

## Description
I decided to use MVVM + Coordinator Patterns. with this approach we can have so many flows and decouple view controllers from each other.
So, for example, when we need to present one ViewController, we can create its view model that already conformed to one protocol, and then inside the coordinator or flow, pass it to the controller just like as (DI). with this procedure, we can call any kind of view controllers and inject our data into them. so when a controller in a flow finished its job or user interact with it, it does not aware of what will happen next. this is Coordinator/Flow job to decide where we should go. just as we are opening settings view controller with AppCoordinator.

**Please see the screen records and screenshots attached with my submission.**
 [**Screen Records**](https://drive.google.com/drive/folders/1-N_0e8XOF7uear8iITI90ZW0Mt3GxolH?usp=sharing) 

I used TableView in Home view controller.
File "*HomeViewController+TableView.swift*" Responsible for handling tableview.

In view model we have sectionNames enum:

```
    public enum SectionNames: Int, CaseIterable {
        case shimmerLoadr = 0
        case repositoryItems = 1
    }
```
It reads the number of cells and sections from the view model. number Of rows for each section depends on what situation we are in loading data to present the right view.

we have 3 Conditions:
- loading without showing cached data: it will show 5 cells with shimmer effect
- loading data while we are presented the cached data: it will show one shimmer cell, and cached data under it
- all data loaded: just show the trending cells without any loading shimmer effect cells

```
    func numberOfSections() -> Int {
        SectionNames.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let selectedSection = SectionNames(rawValue: section)
        switch selectedSection {
        case .shimmerLoadr:
            if isCachedDataLoaded && (isLoadingData.value ?? false) {
                return 1
            } else {
                return (dataSource.value?.count ?? 0) > 0 ? 0 : 5
            }
            
        case .repositoryItems:
            return dataSource.value?.count ?? 0
            
        case .none:
            return 0
        }
    }
```

For loading data we can specify which option or parameters we need to pass by using enums: **SortBy** , **Languages**.
So when we are calling endpoint we are not dealing with raw strings. You can find more details [here](https://docs.github.com/en/rest/search#search-repositories).
```
struct APIParameters {
    
    struct SearchParams: Encodable {
        enum SortBy: String, Encodable  {
            case stars = "stars"
            case forks = "forks"
            case helpWantedIssues = " help-wanted-issues"
            case updated = "updated"
        }
        
        enum Languages: String, Encodable {
            case all = "language"
            case go = "language:go"
            case swift = "language:swift"
            case python = "language:python"
        }
        
        var q: Languages
        var sort: SortBy?
        var per_page: Int?
    }
}
```
## Caching and Settings
Based on Github Api documentation, we are going to have [TimeOut](https://docs.github.com/en/rest/overview/troubleshooting#timeouts) in some circumstances. So from the user's perspective, it is not a good behavior to not load any data. I created cached mechanism based on **CoreData** to store the last recieved data from server. So if user enabled to see the cached files in **Settings** page, first app will load the cached data and populate the table view also it will show just one shimmer cell on top to present the loadding data is running.
All database functions are managing by **CoreDataManager** which is a singletone class.
For storing basic user settings I used **UserDefaults** and managing it inside **UserDefaultManager**.
*UserDefaultManager* uses enums to store data so we will not be dealing with raw Strings and it has the ability to distinguish data type by defining storing and retrieving functions in its extension.


## Logger
I used a Log class that will be only print in Debug mode and also show the class, function and line. so it will be easier to debug when we are using this Logger.
```
[ℹ️ INFO] Cached data loaded ➜ HomeViewModel.swift: 92 getCachedData()
```


## To be improved

- Creating UIs in code
- Chacing  mechanism
- Unit test / UI test

### Creator:
Sajjad Sarkoobi
https://www.linkedin.com/in/sajjad-sarkoobi/
https://www.youtube.com/@swiftacademy
