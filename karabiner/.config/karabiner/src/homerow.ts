import { mapSimultaneous, rule } from 'karabiner.ts'

export function homerow() {
  return [
    rule('Homerow').manipulators([
      mapSimultaneous(['f', 'j']).to('␣', 'Hyper'), // Click
      mapSimultaneous(['f', 'k']).to('⏎', 'Hyper'), // Scroll
    ]),
  ]
}
