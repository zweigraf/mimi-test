# mimi-test
Repository for the Mimi Coding Challenge

## Scope

- Localization is not taken under consideration. All strings are hardcoded in English.
- Error Handling is limited to alerts shown to the user.
- Tested on Xcode 11.2.1, macOS 10.14.6, iPhone X, iOS 13.2.
- No loading state is implemented.

## Architecture

The architecture is VIPER-ish. Some ideas have been taken but some decisions have been made to reduce the amount of code for this small app. There is no presenter. The PRESENTER's tasks are distributed between the VIEW and the INTERACTOR. Also, there is only one ROUTER for the whole application, whereas in proper VIPER each module would get its own.

Entry point of the application is in SceneDelegate. It creates all dependencies and asks the router to create the main screen. Router injects the dependencies into the screen, creating them (Interactor) when necessary.

## Notes

- I built my own `UITableViewCell` subclass `TableViewCell` due to not getting the image view layouted correctly without glitches when using my async loading class `ImageLoader`.
- I prefer to do all my UI in code. 
- All dependencies are created in `SceneDelegate` and injected into places where it's needed via constructor injection.
- Due to the Top Songs info not containing all information about the artist, esp. the track count, there is a ShortArtist and a FullArtist model. The view model that is responsible for the artist information on the top artists page then fetches the detailed information about the artist lazily.

