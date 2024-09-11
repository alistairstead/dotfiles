import { duoLayer, map, rule, to$ } from 'karabiner.ts'

const layerMap = {
  c: toRaycastExt$('raycast/calendar/my-schedule'),
  h: toRaycastExt$('raycast/clipboard-history/clipboard-history'),
  p: toRaycastExt$('raycast/raycast/confetti', true),
  l: toRaycastExt$('raycast/raycast/search-quicklinks', true),
  t: toRaycastExt$('doist/todoist/home'),
  n: toRaycastExt$('KevinBatdorf/obsidian/createNoteCommand'),
}

export function raycastLayer() {
  return [
    duoLayer(';', 'r')
      .description('Raycast Layer')
      .leaderMode({ sticky: false, escape: [';', 'escape', 'spacebar'] })
      .manipulators(layerMap),
    rule('command + shift + v → Raycast clipboard history').manipulators([
      map({
        key_code: 'v',
        modifiers: { mandatory: ['command', 'shift'] },
      }).to(toRaycastExt$('raycast/clipboard-history/clipboard-history')),
    ]),
  ]
}

export function toRaycastExt$(name: string, background = false) {
  return to$(`open ${background ? '-g' : ''} raycast://extensions/${name}`)
}

export function toRaycastWin$(name: string) {
  return to$(`open -g raycast://extensions/raycast/window-management/${name}`)
}
