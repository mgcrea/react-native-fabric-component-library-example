import React from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
import {NativeColorView} from 'react-native-color-view';

const COLORS = ['#32a852', '#a83232', '#32a8a8', '#a832a8'];

function App(): React.JSX.Element {
  const [colorIndex, setColorIndex] = React.useState(0);
  const onPress = () => {
    setColorIndex((colorIndex + 1) % COLORS.length);
  };
  return (
    <View style={styles.container}>
      <NativeColorView
        color={COLORS[colorIndex]}
        style={styles.box}
        onTap={() => {
          console.log('Tapped from JS');
        }}>
        <Text>ColorView2</Text>
        <View style={styles.innerBox} />
      </NativeColorView>
      <Button title="Change Color" onPress={onPress} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'palegreen',
  },
  webview: {
    width: '100%',
    height: '100%',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
    // backgroundColor: 'red',
    borderColor: 'black',
    borderWidth: 1,
  },
  innerBox: {
    width: 120,
    height: 120,
    marginVertical: 1,
    backgroundColor: 'red',
    borderColor: 'black',
    borderWidth: 1,
  },
  picker: {
    width: 300,
    height: 100,
    // backgroundColor: 'blue',
    // borderColor: 'black',
    // borderWidth: 1,
  },
  menu: {
    width: 200,
    height: 100,
    // borderColor: 'black',
    // borderWidth: 1,
  },
});

export default App;
