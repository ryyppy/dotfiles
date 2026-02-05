local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node

return {
    s("des", {
      t "describe('",
      i(1, "description"),
      t { "', function() {", "\t" },
      i(0),
      t { "", "});" },
    }),

    s("it", {
      t "it('",
      i(1, "description"),
      t { "', async function() {", "\t" },
      i(0),
      t { "", "});" },
    }),

    s("test", {
      t "test('",
      i(1, "description"),
      t { "', async function() {", "\t" },
      i(0),
      t { "", "});" },
    }),

    s("bef", {
      t "beforeEach(function() {",
      i(0),
      t { "", "});" },
    }),

    s("aft", {
      t "afterEach(function() {",
      i(0),
      t { "", "});" },
    }),
    -- Add more snippets here following the same pattern
}

-- More file types can be added in a similar way
