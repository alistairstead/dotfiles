import { ifApp, map, rule, toKey, withCondition } from 'karabiner.ts'
import { tapModifier, toResizeWindow } from './utils'

export function appsMapping() {
  let historyNavi = [
    // Back/Forward history in most apps
    map('p', '⌃').to('[', '⌘'),
    map('n', '⌃').to(']', '⌘'),
  ]
  let tabNavi = [
    // Pre/Next tab in most apps
    map('p', '⌥').to('[', '⌘⇧'),
    map('n', '⌥').to(']', '⌘⇧'),
  ]
  let switcher = [
    // Pre/Next switcher in most apps
    map('p', '⌘⌥⌃').to('⇥', '⌃⇧'),
    map('n', '⌘⌥⌃').to('⇥', '⌃'),
  ]

  // Tap ‹⌘ -> Show/Hide UI (e.g. left sidebars)
  // Tap ‹⌥ -> Run current task (re-run)
  // Tap ‹⌃ -> Run list
  // Tap ›⌘ -> Show/Hide UI (e.g. right sidebars)
  // Tap ›⌥ -> Command Palette (e.g. ⌘K, ⌘P)
  // Tap ›⌃ -> History (e.g. recent files)

  return [
    rule('app mappings').manipulators([
      //region Chrome
      withCondition(ifApp('^com.google.Chrome$'))([
        ...historyNavi,
        ...tabNavi,
        ...switcher,

        tapModifier('‹⌥', toKey('r', '⌘')), // refreshThePage

        tapModifier('›⌘', toKey('i', '⌘⌥')), // developerTools
        tapModifier('›⌥', toKey('a', '⌘⇧')), // searchTabs

        map(1, 'Meh').to(toResizeWindow('Google Chrome')),
      ]),
      //endregion

      //region Safari
      withCondition(ifApp('^com.apple.Safari$'))([
        ...historyNavi,
        ...tabNavi,
        ...switcher,

        tapModifier('‹⌘', toKey('l', '⌘⇧')), // showHideSideBar
        tapModifier('‹⌥', toKey('r', '⌘')), // reloadPage

        tapModifier('›⌘', toKey('i', '⌘⌥')), // showWebInspector

        map(1, 'Meh').to(toResizeWindow('Safari')),
      ]),
      //endregion

      //region Slack
      withCondition(ifApp('^com.tinyspeck.slackmacgap$'))([
        ...historyNavi,

        tapModifier('‹⌘', toKey('d', '⌘⇧')), // showHideSideBar
        tapModifier('‹⌥', toKey('f6')), // moveFocusToTheNextSection

        tapModifier('›⌘', toKey('.', '⌘')), // hideRightBar
        tapModifier('›⌥', toKey('k', '⌘')), // open

        map(1, 'Meh').to(
          // After the 1/4 width, leave some space for opening thread in a new window
          // before the last 1/4 width
          toResizeWindow('Slack', { x: 1263, y: 25 }, { w: 1760, h: 1415 }),
        ),
      ]),
      //endregion

      //region Spark
      withCondition(ifApp('^com.readdle.SparkDesktop'))([
        tapModifier('‹⌘', toKey('/')), // openSidebar
        tapModifier('‹⌥', toKey('r', '⌘')), // fetch

        tapModifier('›⌘', toKey('/', '⌘')), // changeLayout
        tapModifier('›⌥', toKey('k', '⌘')), // actions

        map(1, 'Meh').to(toResizeWindow('Spark Desktop')),
      ]),
      //endregion

      //region 1Password
      withCondition(ifApp('^com.agilebits.onepassword7'))([
        map('j', ['left_control']).to(toKey('down_arrow')),
        map('n', ['left_control']).to(toKey('down_arrow')),
        map('k', ['left_control']).to(toKey('up_arrow')),
        map('p', ['left_control']).to(toKey('up_arrow')),
      ]),
      //endregion
    ]),
  ]
}
