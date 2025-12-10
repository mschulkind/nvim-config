# Plugin System Explained

## Installation: Single Batch, Controlled Load Order

The plugin system uses a **3-phase approach** to ensure proper dependency ordering:

### Phase 1: Collection

- Recursively walk through all plugins and their dependencies
- Build a complete list of URLs to install
- Deduplicates automatically (same plugin won't be collected twice)

### Phase 2: Batch Installation (Without Loading)

- **Single call to `vim.pack.add(urls, { load = false })`**
- Installs all plugins on disk in one operation
- **Single confirmation prompt** for fresh installs
- Plugins are NOT loaded yet - just downloaded and made available
- This is key: `load = false` means plugins are installed but `:packadd` hasn't run yet

### Phase 3: Ordered Loading with `:packadd`

- Loads plugins recursively in dependency order
- For each plugin:
  1. Load all dependencies first (recursively)
  2. Run `init()` function (sets global vars before plugin loads)
  3. Call `:packadd plugin_name` (actually loads the plugin into runtime)
  4. Run `config()` function (configure the loaded plugin)
  5. Apply `opts` (if no config)
  6. Apply keymaps

**This approach ensures:**
- ✅ Single installation prompt
- ✅ Complete control over load order
- ✅ Dependencies always load before dependents
- ✅ No race conditions or timing issues

## `init` vs `config`: Critical Difference

### `init()`
- **When**: Runs BEFORE the plugin is loaded into Neovim's runtime
- **Purpose**: Set Vim/Neovim global variables that the plugin checks during load
- **Use case**: The plugin's own code reads these variables on startup
- **Example**: 
  ```lua
  init = function()
    vim.g.NERDCreateDefaultMappings = 0  -- Plugin checks this during load
  end
  ```

### `config()`
- **When**: Runs AFTER the plugin is fully loaded
- **Purpose**: Configure the plugin by calling its Lua API
- **Use case**: Running the plugin's `setup()` function or other configuration
- **Example**:
  ```lua
  config = function()
    require("mason").setup({ ui = { border = "single" } })
  end
  ```

### Why This Matters

Some plugins check global variables (`vim.g.*`) **as they load**. If you set these in `config()`, it's too late - the plugin has already loaded and read the default values.

**Example with NERDCommenter:**
```lua
-- ❌ WRONG - Too late, plugin already created default mappings
{
  "preservim/nerdcommenter",
  config = function()
    vim.g.NERDCreateDefaultMappings = 0  -- Plugin already loaded!
  end
}

-- ✅ CORRECT - Set before plugin loads
{
  "preservim/nerdcommenter", 
  init = function()
    vim.g.NERDCreateDefaultMappings = 0  -- Set before plugin loads
  end
}
```

## Dependency Loading: Automatic and Recursive

### Example: Mason Tools

File: `lua/plugins/mason_tools.lua`
```lua
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({ ... })
    end,
  },
}
```

File: `lua/plugins/mason.lua`
```lua
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({ ... })
    end,
  },
}
```

### What Happens

When loading `mason-tool-installer.nvim`:

1. **Sees dependency**: `mason.nvim`
2. **Recursively loads** `mason.nvim`:
   - Runs mason's `init()` (if present)
   - Plugin loads into runtime
   - Runs mason's `config()` → `require("mason").setup()` executes
3. **Then loads** `mason-tool-installer.nvim`:
   - Runs its `init()` (if present)
   - Plugin loads into runtime  
   - Runs its `config()` → can successfully call `require("mason-tool-installer")` because Mason is set up

### Yes, It Auto-Loads from Separate Files!

Even though mason.nvim and mason-tool-installer.nvim are defined in separate files, the dependency resolution happens **after** all files are discovered but **before** loading begins.

**Flow:**
1. **Discovery**: Read all `lua/plugins/*.lua` files → builds `M.plugins` table
2. **Collection**: Traverse dependency tree → builds install list
3. **Installation**: Single batch install
4. **Loading**: Recursive dependency-first loading with init/config

So yes, declaring `dependencies = { "williamboman/mason.nvim" }` will:
- Find the full plugin spec from `mason.lua`
- Load and configure it completely
- THEN load and configure mason-tool-installer

No more race conditions or timing issues!

## Load Order Example

Given these plugins:
```
A (no deps)
B (depends on A, C) 
C (no deps)
D (depends on B)
```

**Installation**: All in one batch: `[A, B, C, D]`

**Loading order**:
1. Start loading D
2. D depends on B → load B first
3. B depends on A, C → load A first, then C
4. A loads: init → load → config
5. C loads: init → load → config
6. B loads: init → load → config
7. D loads: init → load → config

**Final order**: A → C → B → D (dependencies always before dependents)
