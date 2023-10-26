return{
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig="int main",
      dscr="main",
      regTrig=false,
      priority=100,
      snippetType="autosnippet",
    },
      fmt( -- The snippet code actually looks like the equation environment it produces.
        [[ 
            #include <stdio.h>

            int main(int argc, char* argv[]){
                /\
                return 0;
            }
        ]],
        -- The insert node is placed in the <> angle brackets
        { i(1) },
        -- This is where I specify that angle brackets are used as node positions.
        { delimiters = "/\\" }
      )
  ),
}
