# Release Notes



## 1.5

These versions:

- Simplifies the app sheet model.



## 1.4

These versions:

- Updates package to Swift 6.0.
- Performs many concurrency changes.
- Updates some package dependencies.
- Localizes the SDK in more locales.
- Redesigns the about screen content.
- Replaces social menu items with app info menu items.
- Removes the `FlipKit` dependency and the `ItemFlipView`.



## 1.3

These versions:

- Updates and adds new dependencies.
- Updates the subscription screen and its info.
- Updates the nav stack to use PresentationKit.
- Removes the `StandardButtons` package dependency.
- Refactors code to avoid using deprecated contexts.
- Refactors `ShareScreen` and adds a `ShareItem` enum.



## 1.2

These versions:

- Update all package dependencies.
- Add a `StandardButtons` package dependency.
- Move onboarding utilities to `OnboardingKit`.



## 1.1

These versions:

- Add a new `OnboardingTip`.
- Add a new `AppAboutScreen`.
- Add a `PremiumTipView` boolean.
- Add a new `AppScreenNavigationStack`.
- Add a new `AppScreenNavigationContext`.
- Add a new `PremiumTip` and `PremiumTipView`.
- Add a new `ShareScreen` view protocol.
- Make beta dependencies use up to next minor.

- The `AppItem` now has less type-specific info.
- The `AppItemAuthContext` now uses `@MainActor`.
- The `AppOnboardingScreen` no longer has a background.
- The `SubscriptionScreen` no longer has a diagonal line.

- This version removes `AppItemAddContext`.
- This version removes `SystemNotification`.


## 0.9 - 1.0

- This version adds a new `AppRootView` type.
- This version adds a new `AppEnvironment` type.
- This version moves StoreKit logic to StoreKitPlus.
- This version lets you customize `SubscriptionScreen`.
- This version lets you customize `AppOnboardingScreen`.
- This version adds a new `SubscriptionScreen.Style` style.
- This version adds new `AppScreenType` and  `AppTabType` types.
- This version adds a new `PremiumToggle` and `DisclosureToggle`.
- This version lets you specify which welcome onboarding to present.


## 0.8

- This version moves alternate app icon logic to a separate SDK. 


## 0.7

- This version updates `BadgeIcon` to 0.5.
- This version updates `OnboardingKit` to 7.0.2.
- This version updates `StoreKitPlus` to 0.3.1.
- This version updates `SwiftUIKit` to 4.3.

- This version removes old notification types.
- This version removes old subscription types.
- This version removes custom onboarding types.
- This version adds new controls, list items and label styles.

- `.appLaunchOnboarding` has been renamed to `.appOnboarding`.
- `SubscriptionScreen` is a new screen with diagonal content.


## 0.6

- This version requires iOS 17, macOS 14, etc.
- This version updates `BadgeIcon` to 0.3.
- This version updates `SwiftUIKit` to 4.1.5.

- `AppInfo` has made the URL properties private.
- `AppInfo` has a new `subscriptionGroupId` property.
- `Color` has more Kankoda-specific colors.
- `DiagonalStyle` now has a `.standard` style.
- `SubscriptionView` replaces `SubscriptionScreenContent`.
- `SubscriptionView` supports macOS and wraps a native view.
- `SubscriptionUsp` has been renamed to `ProductUsp`.
- `SubscriptionUspLabel` has been renamed to `ProductUspLabel`.
- `TutorialScreenContent` now builds on macOS.
- `TutorialScreenContent` now uses `Tutorial` instead of `LocalizedTutorial`.


## 0.5

- The library now builds on all platforms.

- `SocialMenuItems` are redesigned to look better on macOS.


## 0.4

- This version localizes all texts.
- This version updates `SwiftUIKit` to 4.0.

- `PremiumFeature` has been renamed to `SubscriptionFeature`.
- `PremiumPurchaseButton` has been renamed to `SubscriptionButton`.
- `PremiumPurchaseInfo` has been renamed to `SubscriptionInfo`.
- `PremiumScreenContent` has been renamed to `SubscriptionScreenContent`.
- `PremiumUsp` has been renamed to `SubscriptionUsp`.
- `PremiumUspLabel` has been renamed to `SubscriptionUsp`.
- `ToolbarButton` replaces all previous buttons.


## 0.3

- `AppItemData` has been replaced by `AppData`.
- `AppItemDataExporter` has been replaced by `AppDataExporter`.
- `AppItemDataImporter` has been replaced by `AppDataImporter`.
- `AuthenticatedAppDataExporter` is a new app data exporter.
- `Exportable` has been renamed to `AppDataExportable` and now uses `AppData`.
- `TextRecognitionContext` is a new type for handling image text recognition.
- `TutorialScreenContent` has fixed the broken animation.  


## 0.2

- `AlternateIconContext` has been reneamed to `AlternateAppIconContext`.  
- `AlternateIconListItem` has been renamed to `AlternateAppIconListItem`.
- `AlternateAppIconListItem` no longer has a size parameter.
- `AppItem` no longer has form data.  
- `ImageCache` has been moved to SwiftUIKit.
- `ImageRepresentable` `jpegData` extension has been moved to SwiftUIKit.


## 0.1

This first version contains a bunch of shared stuff from other apps.
