import UIKit

/*
 iOS APPLICATION LIFE CYCLE EXPLAINED
 ====================================
 
 Think of an iOS app like a house. Just like a house has different states
 (empty, people moving in, people living in it, people leaving, etc.),
 an iOS app also has different states during its lifetime.
 
 THE 5 MAIN STATES:
 
 1. NOT RUNNING - The app is not started yet (like an empty house)
 2. INACTIVE - The app is starting but not ready for user interaction
 3. ACTIVE - The app is running and user can interact with it (people living normally)
 4. BACKGROUND - The app is running but not visible (people are in the house but you can't see them)
 5. SUSPENDED - The app is paused in memory but not running (people are sleeping)
 
 */

// MARK: - App Delegate Methods (The Main House Manager)

/*
 AppDelegate is like the house manager. It handles what happens
 when the app changes states. Here are the main methods:
 */

class ExampleAppDelegate: UIResponder, UIApplicationDelegate {
    
    // 1. App is starting up for the first time
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("🚀 App is starting up!")
        print("This happens when user taps the app icon")
        print("Good place to set up initial data, databases, etc.")
        
        // Do initial setup here
        setupDatabase()
        setupNotifications()
        
        return true
    }
    
    // 2. App becomes active (user can interact)
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("✅ App is now ACTIVE - user can interact")
        print("This happens when:")
        print("- App starts fresh")
        print("- User comes back from phone call")
        print("- User dismisses control center")
        
        // Resume tasks that were paused
        startLocationServices()
        resumeTimers()
    }
    
    // 3. App is about to become inactive
    func applicationWillResignActive(_ application: UIApplication) {
        print("⏸️ App is becoming INACTIVE")
        print("This happens when:")
        print("- Phone call comes in")
        print("- User pulls down control center")
        print("- User switches to another app")
        
        // Pause tasks that shouldn't run when inactive
        pauseGame()
        saveUserData()
    }
    
    // 4. App goes to background
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("🔄 App is now in BACKGROUND")
        print("App is not visible but might still run for a short time")
        print("Good time to save data and prepare for suspension")
        
        // Save important data
        saveAllData()
        
        // You have about 30 seconds to finish background tasks
        let backgroundTask = application.beginBackgroundTask {
            // This runs when time is up
            print("Background time is up!")
        }
        
        // Do quick background work
        Task {
            // Finish important tasks on background thread
            await self.uploadPendingData()
            
            // End the background task on main thread
            await MainActor.run {
                application.endBackgroundTask(backgroundTask)
            }
        }
    }
    
    // 5. App comes back from background
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("🔙 App is coming back from BACKGROUND")
        print("User tapped the app icon or switched back to it")
        
        // Refresh data that might have changed
        refreshUserInterface()
        checkForNewMessages()
    }
    
    // 6. App is about to be terminated
    func applicationWillTerminate(_ application: UIApplication) {
        print("💀 App is about to be TERMINATED")
        print("This is rare - usually happens when:")
        print("- Device runs out of memory")
        print("- User force-quits the app")
        print("- System needs resources")
        
        // Last chance to save critical data
        saveCriticalData()
    }
}

// MARK: - Scene Delegate (For iOS 13+)

/*
 iOS 13 introduced Scene Delegate for handling multiple windows.
 Think of it like having multiple rooms in your house.
 */

@available(iOS 13.0, *)
class ExampleSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // Scene is connecting
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("🏠 New scene (window) is connecting")
        // Set up the window and initial view controller
    }
    
    // Scene becomes active
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("✅ Scene is now ACTIVE")
        // Similar to applicationDidBecomeActive
    }
    
    // Scene will become inactive
    func sceneWillResignActive(_ scene: UIScene) {
        print("⏸️ Scene is becoming INACTIVE")
        // Similar to applicationWillResignActive
    }
    
    // Scene enters background
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("🔄 Scene entered BACKGROUND")
        // Similar to applicationDidEnterBackground
    }
    
    // Scene enters foreground
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔙 Scene entering FOREGROUND")
        // Similar to applicationWillEnterForeground
    }
}

// MARK: - View Controller Life Cycle

/*
 Each screen (View Controller) also has its own life cycle.
 Think of each screen like a room in your house.
 */

class ExampleViewController: UIViewController {
    
    // 1. View is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        print("📱 View loaded into memory")
        print("This happens ONCE when the screen is created")
        
        // Set up UI elements that don't change
        setupUI()
        setupConstraints()
    }
    
    // 2. View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("👁️ View will appear on screen")
        print("This happens EVERY TIME before the screen shows")
        
        // Refresh data that might have changed
        loadFreshData()
        updateUI()
    }
    
    // 3. View did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("✨ View appeared on screen")
        print("Screen is now fully visible and interactive")
        
        // Start animations, timers, location services
        startAnimations()
        startTimer()
    }
    
    // 4. View will disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("👋 View will disappear from screen")
        print("User is navigating away from this screen")
        
        // Save user input, stop timers
        saveUserInput()
        stopTimer()
    }
    
    // 5. View did disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("🚫 View disappeared from screen")
        print("Screen is no longer visible")
        
        // Clean up resources, stop expensive operations
        stopAnimations()
        pauseVideoPlayback()
    }
    
    // 6. View is removed from memory
    deinit {
        print("🗑️ View controller is being destroyed")
        print("This happens when the screen is no longer needed")
        
        // Clean up observers, delegates, etc.
        removeNotificationObservers()
    }
}

// MARK: - Helper Methods (Example implementations)

extension ExampleAppDelegate {
    
    func setupDatabase() {
        print("Setting up database...")
    }
    
    func setupNotifications() {
        print("Setting up notifications...")
    }
    
    func startLocationServices() {
        print("Starting location services...")
    }
    
    func resumeTimers() {
        print("Resuming timers...")
    }
    
    func pauseGame() {
        print("Pausing game...")
    }
    
    func saveUserData() {
        print("Saving user data...")
    }
    
    func saveAllData() {
        print("Saving all data...")
    }
    
    func uploadPendingData() async {
        print("Uploading pending data...")
        // Simulate some work with async delay instead of Thread.sleep
        try? await Task.sleep(for: .seconds(2))
    }
    
    func refreshUserInterface() {
        print("Refreshing UI...")
    }
    
    func checkForNewMessages() {
        print("Checking for new messages...")
    }
    
    func saveCriticalData() {
        print("Saving critical data...")
    }
}

extension ExampleViewController {
    
    func setupUI() {
        print("Setting up UI elements...")
    }
    
    func setupConstraints() {
        print("Setting up constraints...")
    }
    
    func loadFreshData() {
        print("Loading fresh data...")
    }
    
    func updateUI() {
        print("Updating UI with new data...")
    }
    
    func startAnimations() {
        print("Starting animations...")
    }
    
    func startTimer() {
        print("Starting timer...")
    }
    
    func saveUserInput() {
        print("Saving user input...")
    }
    
    func stopTimer() {
        print("Stopping timer...")
    }
    
    func stopAnimations() {
        print("Stopping animations...")
    }
    
    func pauseVideoPlayback() {
        print("Pausing video playback...")
    }
    
    nonisolated func removeNotificationObservers() {
        print("Removing notification observers...")
    }
}

// MARK: - Real World Example

/*
 REAL WORLD SCENARIO: A Music Player App
 
 1. User taps app icon:
    - didFinishLaunching: Load saved playlists
    - viewDidLoad: Set up player controls
    - viewWillAppear: Check if music was playing before
    - viewDidAppear: Resume music if it was playing
    - didBecomeActive: Update now playing info
 
 2. Phone call comes in:
    - willResignActive: Pause music automatically
    - didEnterBackground: Save current song position
 
 3. User returns to app:
    - willEnterForeground: Prepare to resume
    - didBecomeActive: Update UI, resume music
 
 4. User switches songs:
    - viewWillDisappear: Save current position
    - (new screen loads)
    - viewDidAppear: Start playing new song
 
 5. User force-quits app:
    - willTerminate: Save all playlists and positions
 */

// MARK: - Key Tips for Developers

/*
 DO's:
 ✅ Save user data in willResignActive
 ✅ Refresh data in willEnterForeground
 ✅ Set up UI in viewDidLoad
 ✅ Start animations in viewDidAppear
 ✅ Clean up resources in viewDidDisappear
 
 DON'Ts:
 ❌ Don't do heavy work in didFinishLaunching (slows startup)
 ❌ Don't assume willTerminate will always be called
 ❌ Don't forget to save data before going to background
 ❌ Don't start timers in viewWillAppear (use viewDidAppear)
 ❌ Don't keep strong references that prevent deinit
 */

print("📚 iOS App Life Cycle explanation complete!")
print("Run this playground to see the method signatures and explanations.")
