package com.sinwave

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack

class SinWaveModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    private var audioTrack: AudioTrack? = null
    private var isPlaying = false

    override fun getName(): String {
        return NAME
    }

    @ReactMethod
    fun playSound(frequency: Double) {
        stopSound()

        val sampleRate = 44100
        val bufferSize = AudioTrack.getMinBufferSize(
            sampleRate,
            AudioFormat.CHANNEL_OUT_MONO,
            AudioFormat.ENCODING_PCM_16BIT
        )

        audioTrack = AudioTrack(
            AudioManager.STREAM_MUSIC,
            sampleRate,
            AudioFormat.CHANNEL_OUT_MONO,
            AudioFormat.ENCODING_PCM_16BIT,
            bufferSize,
            AudioTrack.MODE_STREAM
        )

        isPlaying = true
        audioTrack?.play()

        Thread {
            val samples = ShortArray(bufferSize)
            val twoPiF = 2 * Math.PI * frequency / sampleRate

            var angle = 0.0
            while (isPlaying) {
                for (i in samples.indices) {
                    samples[i] = (Short.MAX_VALUE * Math.sin(angle)).toInt().toShort()
                    angle += twoPiF
                    if (angle > 2 * Math.PI) angle -= 2 * Math.PI
                }
                audioTrack?.write(samples, 0, samples.size)
            }
        }.start()
    }

    @ReactMethod
    fun stopSound() {
        if (isPlaying) {
            isPlaying = false
            audioTrack?.stop()
            audioTrack?.release()
            audioTrack = null
        }
    }

    companion object {
        const val NAME = "SinWave"
    }
}
