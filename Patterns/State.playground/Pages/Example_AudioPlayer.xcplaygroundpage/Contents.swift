//: State Pattern. Audio Player Example.
//:
//: Reference: https://refactoring.guru/design-patterns/state
//:
//: ![Audio Player](AudioPlayer.png)

// MARK: - Context
class AudioPlayer {
    var state: StateType,
        playback: Bool = false
    
    init() {
        self.state = ReadyState(player: nil)
        self.state = ReadyState(player: self)
    }
    
    func click_lock() { state.click_lock() }
    func click_play() { state.click_play() }
    func click_next() { state.click_next() }
    func click_previous()  { state.click_previous() }
}


// MARK: - State
protocol StateType {
    var player: AudioPlayer? { get }
    
    func click_lock()
    func click_play()
    func click_next()
    func click_previous()
}
extension StateType {
    func click_next() { print("Next track playing") }
    func click_previous() { print("Prev track playing") }
}

// MARK: Implementation
struct LockedState: StateType {
    var player: AudioPlayer?
    
    init(player: AudioPlayer?) {
        print("Player now locked")
        self.player = player
    }
    
    func click_lock() {
        if let player = player {
            player.state = player.playback ? PlayingState(player: player) : ReadyState(player: player)
        }
    }
    func click_play() { }
}

struct ReadyState: StateType {
    var player: AudioPlayer?
    init(player: AudioPlayer?) {
        guard let _ = player else {
            print("Player not ready")
            return
        }
        print("Player now ready")
        self.player = player
    }
    
    func click_lock() {
        if let player = player {
            player.state = LockedState(player: player)
        }
    }
    func click_play() {
        if let player = player {
            player.playback = true
            player.state = PlayingState(player: player)
        }
    }
}

struct PlayingState: StateType {
    var player: AudioPlayer?
    init(player: AudioPlayer?) {
        print("Player now playing")
        self.player = player
    }
    
    func click_lock() {
        if let player = player {
            player.state = LockedState(player: player)
        }
    }
    func click_play() {
        if let player = player {
            player.playback = false
            player.state = ReadyState(player: player)
        }
    }
}


// MARK: - Main
let audioPlayer = AudioPlayer()

audioPlayer.click_play()
audioPlayer.click_lock()
audioPlayer.click_lock()
audioPlayer.click_play()
