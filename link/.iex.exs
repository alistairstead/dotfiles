IEx.configure(colors: [enabled: true],
              default_prompt: [
                "\e[G",
                "\e[3m\e[1m",
                "%prefix(",
                "\e[0m\e[1m",
                "%counter",
                "\e[3m\e[1m",
                ")>",
                "\e[0m"
              ] |> IO.chardata_to_string())
