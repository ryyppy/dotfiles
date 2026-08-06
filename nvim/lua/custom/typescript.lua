---@mod custom.typescript TypeScript LSP helpers
---
--- Helpers for making `typescript-language-server` find a usable `tsserver.js`.
---
--- Some workspaces intentionally split the TypeScript compiler used by CI from
--- the JavaScript language service used by editors. A common migration pattern is
--- to use the TypeScript 7 native compiler for `tsc`, while keeping the
--- TypeScript 6 JavaScript API available through the `typescript` package name
--- for tools such as `tsserver`. With pnpm aliases, that means
--- `node_modules/typescript` can be an alias package whose real `tsserver.js` is
--- hidden behind another dependency.
---
--- `typescript-language-server` only auto-detects simple layouts such as
--- `node_modules/typescript/lib/tsserver.js`, so this module asks Node's own
--- resolver to find the workspace TypeScript package and follows the TS6 alias
--- layout when needed.

local M = {}

local tsserver_resolver_script = [=[
const fs = require('node:fs');
const path = require('node:path');
const { createRequire } = require('node:module');

function printIfFile(file) {
  if (fs.existsSync(file) && fs.statSync(file).isFile()) {
    console.log(file);
    process.exit(0);
  }
}

let requireFromRoot;
try {
  requireFromRoot = createRequire(path.join(process.cwd(), 'package.json'));
} catch {
  process.exit(1);
}

try {
  printIfFile(requireFromRoot.resolve('typescript/lib/tsserver.js'));
} catch {}

let tsPackageJson;
try {
  tsPackageJson = requireFromRoot.resolve('typescript/package.json');
} catch {
  process.exit(1);
}

const tsDir = path.dirname(tsPackageJson);
printIfFile(path.join(tsDir, 'lib', 'tsserver.js'));

try {
  const requireFromTypescript = createRequire(path.join(tsDir, 'lib', 'typescript.js'));
  printIfFile(requireFromTypescript.resolve('@typescript/old/lib/tsserver.js'));
} catch {}

process.exit(1);
]=]

function M.resolve_tsserver_path(root_dir)
  if not root_dir or vim.fn.executable 'node' ~= 1 then
    return nil
  end

  local result = vim.system({ 'node', '-e', tsserver_resolver_script }, {
    cwd = root_dir,
    text = true,
  }):wait()

  if result.code ~= 0 then
    return nil
  end

  local tsserver_path = vim.trim(result.stdout or '')
  if tsserver_path == '' then
    return nil
  end

  return tsserver_path
end

return M
