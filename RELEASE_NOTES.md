# Release Notes


## 1.1.0

- `AppNotification` is a new struct.
- `AppOnboarding` is a new struct.
- `DiagonalContent` has been simplified.
- `DiagonalScreen` has been renamed to `DiagonalContent`.
- `PremiumSubscriptionScreen` has been renamed to `PremiumScreenContent`.
- `SocialMenuItems` menu is now full width interactable.
- `SystemNotification` and `OnboardingKit` are now pulled in by the package.
- `TutorialScreenContent` is a new view that displays standardized tutorial pages. 


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
