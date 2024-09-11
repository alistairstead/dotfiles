import { duoLayer, rule, to$, withModifier } from 'karabiner.ts'

export const toYabai$ = (command: string) =>
  to$(`/opt/homebrew/bin/yabai -m ${command}`)

const keymap = [
  // Go to space
  withModifier('left_command')({
    1: toYabai$('window --space 1'),
    2: toYabai$('window --space 2'),
    3: toYabai$('window --space 3'),
    4: toYabai$('window --space 4'),
    5: toYabai$('window --space 5'),
    6: toYabai$('window --space 6'),
    7: toYabai$('window --space 7'),
    8: toYabai$('window --space 8'),
    9: toYabai$('window --space 9'),
    0: toYabai$('window --space 10'),
    // 1: toYabai$('space --focus 1'),
    // 2: toYabai$('space --focus 2'),
    // 3: toYabai$('space --focus 3'),
    // 4: toYabai$('space --focus 4'),
    // 5: toYabai$('space --focus 5'),
    // 6: toYabai$('space --focus 6'),
    // 7: toYabai$('space --focus 7'),
    // 8: toYabai$('space --focus 8'),
    // 9: toYabai$('space --focus 9'),
    // 0: toYabai$('space --focus 10'),
    h: toYabai$('window --resize right:-100:0'),
    j: toYabai$('window --resize bottom:0:100'),
    k: toYabai$('window --resize top:0:-100'),
    l: toYabai$('window --resize right:100:0'),
  }),
  // focus window
  { f: toYabai$('window --toggle zoom-fullscreen') },
  // move window
  // flip & rotate windows
  { r: toYabai$('space --rotate 270') },
  { t: toYabai$('space --toggle float') },
  { x: toYabai$('space --mirror x-axis') },
  { y: toYabai$('space --mirror y-axis') },
  { z: toYabai$('window --toggle zoom-fullscreen') },
  { '=': toYabai$('space --balance') },
  { tab: toYabai$('space --focus recent') },
]

// const hints = Object.keys(keymap).join(' ')

export function yabaiLayer() {
  return [
    duoLayer('w', ';')
      .description('Yabai Layer')
      .leaderMode({ sticky: true, escape: [';', 'escape'] })
      .notification(`Yabai:`)
      .manipulators(keymap),
    rule('Yabai focus window').manipulators([
      withModifier('left_option')({
        h: toYabai$('window --focus west'),
        j: toYabai$('window --focus south'),
        k: toYabai$('window --focus north'),
        l: toYabai$('window --focus east'),
        f: toYabai$('window --toggle zoom-fullscreen'),
        // choose layout
        s: toYabai$('space --layout stack'),
        t: toYabai$('space --layout bsp'),
        b: toYabai$('space --balance'),
      }),
    ]),
    rule('Yabai move window').manipulators([
      withModifier(['left_option', 'left_shift'])({
        h: toYabai$('window --swap west'),
        j: toYabai$('window --swap south'),
        k: toYabai$('window --swap north'),
        l: toYabai$('window --swap east'),
      }),
    ]),
  ]
}
