# Release Notes


## 1.2

- `AlternateIconContext` is reneamed to `AlternateAppIconContext`.  
- `AlternateIconListItem` is renamed to `AlternateAppIconListItem`.
- `AlternateAppIconListItem` no longer has a size parameter.


## 1.1

The library adds new depedendencies and a bunch of new functionality. 

- `AppNotification` is a new struct.
- `AppOnboarding` is a new struct.
- `DiagonalContent` has been simplified.
- `DiagonalScreen` has been renamed to `DiagonalContent`.
- `Items` is a new namespace with app-items related types.
- `LocalizedTutorial.welcome` is a new, standard welcome tutorial.
- `PremiumFeature` is a new protocol.
- `PremiumProduct` is renamed to `AppProduct` and converted to `struct`.
- `PremiumSubscriptionScreen` has been renamed to `PremiumScreenContent`.
- `SocialMenuItems` now uses a disclosure group instead of a menu.
- `SystemNotification` and `OnboardingKit` are now pulled in by the package.
- `TutorialScreenContent` is a new view that displays standardized tutorial pages.
- `View` has a new `.standardLaunchOnboarding` modifier that performs a launch onboarding flow.



## 1.0.4

- `AppInfo` has a new `appUrlScheme` property.
- `AppUrls` has a new `app` property.



## 1.0.3

- `AppInfo` now requires a `privacyUrl`.



## 1.0.2

- `AppInfo` has a new computed `.urls` property
- `AppInfo` has a new static `.preview` property
- `PremiumSubscriptionScreen` is now created with an `AppInfo` value.
- `SocialListItem` view is renamed to `SocialMenuItems`.
- `SocialMenuItem` view has a new initializer for icon customization



## 1.0.1

- `AppInfo` is a new struct with app icons.
- `AppUrls` is a new struct with app urls.
- `SocialListItem` is a new view that can be used in the main menu.



## 1.0

- This first version contains a bunch of shared stuff from other apps.
