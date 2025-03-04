# react-native-sin-wave

A React Native library for generating and playing sine wave sounds.

## Installation

```sh
npm install react-native-sin-wave
```

or

```sh
yarn add react-native-sin-wave
```

### iOS Setup

Ensure you have `AVFoundation` linked in your Xcode project:

1. Open `ios/SoundGeneratorExample.xcworkspace` in Xcode.
2. Select your project in the left sidebar.
3. Go to **Build Phases** > **Link Binary With Libraries**.
4. Add `AVFoundation.framework` if it's not already there.
5. Run `cd ios && pod install` in your terminal.

## Usage

### Import the module

```js
import SoundGenerator from 'react-native-sin-wave';
```

### Play a Sound

```js
SoundGenerator.playSound(440); // Plays a 440 Hz sine wave (A4 note)
```

### Stop the Sound

```js
SoundGenerator.stopSound();
```

## API

### `playSound(frequency: number): void`

Plays a sine wave of the given frequency (in Hz).

**Example:**

```js
SoundGenerator.playSound(528); // Play a 528 Hz frequency
```

### `stopSound(): void`

Stops the currently playing sound.

**Example:**

```js
SoundGenerator.stopSound();
```

## Platform Support

- **Android:** Uses `AudioTrack` API for sound synthesis.
- **iOS:** Uses `AVFoundation` for sound synthesis.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
