return {
  -- Example: how to set snippet parameters
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="latex setup",
      dscr="Org Latex Startupfile",
      regTrig=false,
      priority=100,
      snippetType="autosnippet"
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t("#+SETUPFILE: ~/setupfile/"),-- A single text node
      i(1),
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="start",
      dscr="Org Latex start",
      regTrig=false,
      priority=100,
      snippetType="autosnippet"
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
          #+TITLE: <>
          #+SUBTITLE: <>
          #+AUTHOR: <>
          #+SETUPFILE: ~/setupfile/latex-standard.setup
          #+OPTIONS: toc:t \n:t
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1), i(2), i(3) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="equation",
      dscr="Latex equation",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
            \begin{equation}
                <>
            \end{equation}
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="code",
      dscr="Code Block",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
            #+BEGIN_SRC <>
                <>
            #+END_SRC
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1), i(2) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="math",
      dscr="Math Block",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
            \[
                <>
            \]
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="frac",
      dscr="Frac Block",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
            \frac{<>}{<>}
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1), i(2) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="sum",
      dscr="Sumation",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[
            \sum_{<>}^{<>}{<>}
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1), i(2), i(3) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "<>" }
      )
  ),
}

