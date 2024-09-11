import { duoLayer, toApp } from 'karabiner.ts'

export function openLayer() {
  return [
    duoLayer('l', ';')
      .description('Apps Layer')
      .leaderMode()
      .notification('Apps:')
      .manipulators({
        b: toApp('Google Chrome'),
        c: toApp('Fantastical'),
        // B: toApp('Safari'),
        f: toApp('Finder'),
        p: toApp('1Password'),
        t: toApp('WezTerm'),
        m: toApp('Spark Desktop'),
        n: toApp('Obsidian'),
        s: toApp('Slack'),
        ',': toApp('System Settings'),
      }),
  ]
}
