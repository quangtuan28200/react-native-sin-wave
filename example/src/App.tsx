import { useState } from 'react';
import { View, StyleSheet, Button, TextInput, Text } from 'react-native';
import { playSound, stopSound } from 'react-native-sin-wave';

export default function App() {
  const [frequency, setFrequency] = useState('440');

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Sound Generator</Text>
      <View style={styles.inputContainer}>
        <TextInput
          placeholder="Frequency (Hz)"
          value={frequency}
          onChangeText={setFrequency}
          keyboardType="numeric"
          style={styles.input}
        />
        <Button
          title="Play Sound"
          onPress={() => playSound(parseFloat(frequency))}
        />
        <Button title="Stop Sound" onPress={() => stopSound()} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  inputContainer: {
    width: '80%',
    backgroundColor: '#eee',
    padding: 20,
    borderRadius: 10,
    gap: 10,
    marginTop: 20,
  },
  input: {
    width: '100%',
    height: 40,
    borderWidth: 1,
    backgroundColor: '#fff',
    borderColor: '#ccc',
    borderRadius: 5,
    paddingHorizontal: 10,
    marginBottom: 10,
  },
});
