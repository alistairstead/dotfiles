import { duoLayer, toKey, withModifier } from 'karabiner.ts'

const hint = `\
←  ↓  ↑  →  ⌫ ⌦
H  J  K  L  ' \\`

export function vimLayer() {
  return [
    duoLayer('f', ';')
      .notification(hint)
      .manipulators([
        withModifier('??')({
          h: toKey('←'),
          j: toKey('↓'),
          k: toKey('↑'),
          l: toKey('→'),

          ';': toKey('›⇧'),
          d: toKey('‹⌘'),
          s: toKey('‹⌃'),
          a: toKey('‹⌥'),
        }),
        {
          "'": toKey('⌫'),
          '\\': toKey('⌦'),
        },
      ]),
  ]
}
