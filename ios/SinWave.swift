import AVFoundation

@objc(SinWave)
class SinWave: NSObject {

    private var audioEngine: AVAudioEngine?
    private var playerNode: AVAudioPlayerNode?
    private var isPlaying = false
    
    @objc func playSound(_ frequency: Double) {
        stopSound()

        audioEngine = AVAudioEngine()
        playerNode = AVAudioPlayerNode()
        
        let sampleRate = 44100.0
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        
        guard let audioEngine = audioEngine, let playerNode = playerNode else { return }
        
        let buffer = createSineWaveBuffer(frequency: frequency, sampleRate: sampleRate, length: Int(sampleRate))
        
        audioEngine.attach(playerNode)
        let mainMixer = audioEngine.mainMixerNode
        audioEngine.connect(playerNode, to: mainMixer, format: format)
        
        do {
            try audioEngine.start()
            playerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            playerNode.play()
            isPlaying = true
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    @objc func stopSound() {
        if isPlaying {
            audioEngine?.stop()
            audioEngine = nil
            playerNode = nil
            isPlaying = false
        }
    }

    private func createSineWaveBuffer(frequency: Double, sampleRate: Double, length: Int) -> AVAudioPCMBuffer {
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        let buffer = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: AVAudioFrameCount(length))!
        buffer.frameLength = AVAudioFrameCount(length)
        
        let samples = buffer.floatChannelData![0]
        for i in 0..<length {
            let time = Double(i) / sampleRate
            samples[i] = Float(sin(2.0 * .pi * frequency * time))
        }
        
        return buffer
    }
}
