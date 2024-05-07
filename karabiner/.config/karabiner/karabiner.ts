import {
  rule,
  map,
  toApp,
  toIfAlone,
  to,
  toKey,
  toNone,
  to$,
  writeToProfile,
  hyperLayer,
} from "https://deno.land/x/karabinerts@1.27.0/deno.ts";

const letters: Array<string> = [];

// Fill the array with strings "1" - "9"
for (let i = 1; i <= 9; i++) {
  letters.push(String(i));
}

// Fill the array with strings "a" - "z"
for (let i = "a".charCodeAt(0); i <= "z".charCodeAt(0); i++) {
  letters.push(String.fromCharCode(i));
}

writeToProfile("Default", [
  rule("Caps Lock → Hyper || Escape").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
  ]),

  rule("Command → Space").manipulators([
    map({
      key_code: "spacebar",
      modifiers: { mandatory: ["command"] },
    }).to({
      key_code: "backslash",
      modifiers: ["left_shift", "left_control", "left_option", "left_command"],
    }),
  ]),

  hyperLayer("o", "hyper-o")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "o", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({
      p: toApp("1Password"),
      t: toApp("WezTerm"),
    }),

  hyperLayer("r", "hyper-h")
    .description("Raycast")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "r", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({
      c: to$("open raycast://extensions/raycast/calendar/my-schedule"),
      h: to$(
        "open raycast://extensions/raycast/clipboard-history/clipboard-history",
      ),
      p: to$("open -g raycast://extensions/raycast/raycast/confetti"),
      u: to$(
        "open -g raycast://extensions/jmaeso/uuid-generator/generate?arguments=%7B%22numberOfUUIDsToGenerate%22%3A%22%22%7D",
      ),
    }),

  hyperLayer("h", "hyper-h")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "h", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({}),
  hyperLayer("j", "hyper-j")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "j", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({}),
  hyperLayer("k", "hyper-k")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "k", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({}),
  hyperLayer("l", "hyper-l")
    .configKey(
      (v) => v.toAfterKeyUp({ key_code: "l", modifiers: ["left_control"] }),
      true,
    )
    .manipulators({}),
  rule("Control + single alpha numeric char").manipulators([
    ...letters.map((letter) =>
      map({
        key_code: letter,
        modifiers: {
          mandatory: ["shift", "control", "option", "command"],
        },
      }).to({
        key_code: letter,
        modifiers: ["left_control"],
      }),
    ),
  ]),
]);
