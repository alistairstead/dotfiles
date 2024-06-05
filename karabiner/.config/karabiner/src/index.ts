import {
  rule,
  map,
  toApp,
  to$,
  writeToProfile,
  hyperLayer,
  FromEvent,
  ToEvent,
} from 'karabiner.ts'

const numericalKeys: Array<string> = []
const alphaKeys: Array<string> = []

// Fill the array with strings "1" - "9"
for (let i = 1; i <= 9; i++) {
  numericalKeys.push(String(i))
}

// Fill the array with strings "a" - "z"
for (let i = 'a'.charCodeAt(0); i <= 'z'.charCodeAt(0); i++) {
  alphaKeys.push(String.fromCharCode(i))
}

const alphaNumericalKeys = [...numericalKeys, ...alphaKeys]

const toYabai = (command: string) =>
  to$(`/opt/homebrew/bin/yabai -m ${command}`)

writeToProfile('Default', [
  rule('Caps Lock → Hyper || Escape').manipulators([
    map('caps_lock').toHyper().toIfAlone('escape'),
  ]),
  // rule('Tab → SuperHyper || Tab').manipulators([
  //   map('tab').toSuperHyper().toIfAlone('tab'),
  // ]),
  rule('Command → Space').manipulators([
    map({
      key_code: 'spacebar',
      modifiers: { mandatory: ['command'] },
    }).to({
      key_code: 'backslash',
      modifiers: ['left_shift', 'left_control', 'left_option', 'left_command'],
    }),
  ]),
  hyperLayer('o', 'hyper-o')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'o', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({
      p: toApp('1Password'),
      t: toApp('WezTerm'),
      m: toApp('Spark Desktop'),
      n: toApp('Obsidian'),
      s: toApp('Safari'),
      c: toApp('Chrome'),
    }),
  hyperLayer('r', 'hyper-r')
    .description('Raycast')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'r', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({
      c: to$('open raycast://extensions/raycast/calendar/my-schedule'),
      h: to$(
        'open raycast://extensions/raycast/clipboard-history/clipboard-history',
      ),
      p: to$('open -g raycast://extensions/raycast/raycast/confetti'),
    }),
  hyperLayer('h', 'hyper-h')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'h', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({}),
  hyperLayer('j', 'hyper-j')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'j', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({}),
  hyperLayer('k', 'hyper-k')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'k', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({}),
  hyperLayer('l', 'hyper-l')
    .configKey(
      (v) => v.toIfAlone({ key_code: 'l', modifiers: ['left_control'] }),
      false,
    )
    .manipulators({}),
  hyperLayer('w', 'hyper-w')
    // .configKey(
    //   (v) => v.toIfAlone({ key_code: 'w', modifiers: ['left_control'] }),
    //   false,
    // )
    .manipulators({
      // Go to space
      1: toYabai('window --space 1'),
      2: toYabai('window --space 2'),
      3: toYabai('window --space 3'),
      4: toYabai('window --space 4'),
      5: toYabai('window --space 5'),
      6: toYabai('window --space 6'),
      7: toYabai('window --space 7'),
      8: toYabai('window --space 8'),
      9: toYabai('window --space 9'),
      0: toYabai('window --space 0'),
      // focus window
      f: toYabai('window --toggle zoom-fullscreen'),
      h: toYabai('window --focus west'),
      j: toYabai('window --focus south'),
      k: toYabai('window --focus north'),
      l: toYabai('window --focus east'),
      // move window
      left_arrow: toYabai('window --swap west'),
      down_arrow: toYabai('window --swap south'),
      up_arrow: toYabai('window --swap north'),
      right_arrow: toYabai('window --swap east'),
      // flip & rotate windows
      r: toYabai('space --rotate 270'),
      t: toYabai('space --toggle float'),
      x: toYabai('space --mirror x-axis'),
      y: toYabai('space --mirror y-axis'),
      z: toYabai('window --toggle zoom-fullscreen'),
      spacebar: toYabai('space --balance'),
      tab: toYabai('space --focus recent'),
      "'": toYabai('space --layout stack'),
      ';': toYabai('space --layout bsp'),
    }),
  rule('Control + single alpha numeric char').manipulators([
    ...alphaNumericalKeys.map((letter) =>
      map({
        key_code: letter,
        modifiers: {
          mandatory: ['shift', 'control', 'option', 'command'],
        },
      } as FromEvent).toIfAlone({
        key_code: letter,
        modifiers: ['left_control'],
      } as ToEvent),
    ),
  ]),
])
