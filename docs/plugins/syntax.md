# Syntax and Language Support Plugins

This document covers language-specific syntax highlighting and file type support plugins.

## 📝 TypeScript Support

### typescript-vim ✅
**Repository**: `leafgarland/typescript-vim`  
**VSCode Compatible**: ✅  
**Purpose**: TypeScript syntax highlighting and indentation

#### Features
- **Syntax highlighting** - Full TypeScript syntax support
- **Indentation** - Proper TypeScript indentation rules
- **File detection** - Automatic .ts file type detection
- **Performance** - Lightweight and fast

#### Supported Features
- **Type annotations** - Highlights type information
- **Interfaces** - Syntax highlighting for interfaces
- **Generics** - Generic type parameter highlighting
- **Decorators** - Decorator syntax support
- **Modules** - ES6 module syntax

## ⚛️ JSX/TSX Support

### vim-jsx-typescript ✅
**Repository**: `peitalin/vim-jsx-typescript`  
**VSCode Compatible**: ✅  
**Purpose**: JSX and TSX syntax highlighting

#### Features
- **JSX syntax** - React JSX syntax highlighting
- **TSX support** - TypeScript JSX syntax
- **Component highlighting** - React component syntax
- **Attribute highlighting** - JSX attribute syntax

#### Supported Features
- **JSX elements** - `<div>`, `<Component>`, etc.
- **JSX attributes** - `className`, `onClick`, etc.
- **TypeScript in JSX** - Type annotations in JSX
- **Fragment syntax** - `<>` and `</>` fragments

## 📄 JSON Support

### vim-jsonc ✅
**Repository**: `kevinoid/vim-jsonc`  
**VSCode Compatible**: ✅  
**Purpose**: JSON with Comments (JSONC) support

#### Features
- **JSONC syntax** - JSON with comment support
- **Comment highlighting** - Proper comment syntax
- **File detection** - Automatic .jsonc file type detection
- **VSCode compatibility** - Matches VSCode's JSONC support

#### Supported Features
- **JSON syntax** - Standard JSON highlighting
- **Comments** - `//` and `/* */` comment support
- **Trailing commas** - Trailing comma support
- **String highlighting** - Proper string syntax

## 🎨 CSS/PostCSS Support

### postcss-syntax.vim ✅
**Repository**: `alexlafroscia/postcss-syntax.vim`  
**VSCode Compatible**: ✅  
**Purpose**: PostCSS syntax highlighting

#### Features
- **PostCSS syntax** - Modern CSS syntax support
- **Nesting** - CSS nesting syntax highlighting
- **Variables** - CSS custom properties support
- **At-rules** - PostCSS at-rule highlighting

#### Supported Features
- **CSS nesting** - `&` selector syntax
- **Custom properties** - `--variable` syntax
- **PostCSS plugins** - Plugin-specific syntax
- **Modern CSS** - Latest CSS features

## 🔍 JSON Query Support

### jq.vim ✅
**Repository**: `vito-c/jq.vim`  
**VSCode Compatible**: ✅  
**Purpose**: jq query language syntax highlighting

#### Features
- **jq syntax** - jq query language highlighting
- **Filter highlighting** - jq filter syntax
- **Function highlighting** - Built-in jq functions
- **Operator highlighting** - jq operators and pipes

#### Supported Features
- **Filters** - `.field`, `.[]`, `.[0]` syntax
- **Functions** - `map`, `select`, `group_by` functions
- **Operators** - `|`, `+`, `-`, `*`, `/` operators
- **Conditionals** - `if-then-else` syntax

## ⚙️ Configuration

### File Type Detection
These plugins automatically detect file types based on extensions:

```lua
-- TypeScript files
*.ts -> typescript-vim

-- TSX files  
*.tsx -> vim-jsx-typescript

-- JSONC files
*.jsonc -> vim-jsonc

-- PostCSS files
*.postcss, *.pcss -> postcss-syntax.vim

-- jq files
*.jq -> jq.vim
```

### VSCode Integration
All syntax plugins work seamlessly with VSCode:
- **Consistent highlighting** with VSCode's syntax
- **File type detection** matches VSCode behavior
- **No conflicts** with VSCode's built-in highlighting

## 🎯 Language-Specific Features

### TypeScript
- **Type annotations** - `: string`, `: number`, etc.
- **Interfaces** - `interface User { ... }`
- **Generics** - `Array<T>`, `Promise<Response>`
- **Enums** - `enum Status { ... }`
- **Namespaces** - `namespace MyNamespace { ... }`

### JSX/TSX
- **Elements** - `<div>`, `<MyComponent>`
- **Attributes** - `className`, `onClick`, `data-*`
- **Children** - `{children}`, `{variable}`
- **Fragments** - `<>...</>`, `<React.Fragment>`

### JSONC
- **JSON syntax** - Objects, arrays, strings, numbers
- **Comments** - `// single line`, `/* multi-line */`
- **Trailing commas** - `{ "key": "value", }`
- **String escaping** - `\"`, `\\`, `\n`, `\t`

### PostCSS
- **Nesting** - `&:hover`, `&.active`
- **Variables** - `var(--color)`, `--primary-color`
- **At-rules** - `@media`, `@keyframes`, `@import`
- **Functions** - `calc()`, `url()`, `rgba()`

### jq
- **Filters** - `.field`, `.[]`, `.[0:5]`
- **Functions** - `map()`, `select()`, `group_by()`
- **Operators** - `|`, `+`, `-`, `*`, `/`
- **Conditionals** - `if .field then .value else .default end`

## 🔧 Advanced Configuration

### Custom File Types
```lua
-- Add custom file type detection
vim.filetype.add({
  extension = {
    mylang = "mylang",
  },
  pattern = {
    [".*%.mylang%.conf"] = "mylang",
  },
})
```

### Syntax Overrides
```lua
-- Override syntax highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript",
  callback = function()
    -- Custom TypeScript highlighting
    vim.cmd("syntax keyword typescriptCustomKeyword myKeyword")
  end,
})
```

## 📚 Related Documentation

- [Essential Plugins](essential.md) - Core functionality plugins
- [Utility Plugins](utilities.md) - Helper and productivity plugins
- [Formatting Plugins](formatting.md) - Code formatting and linting
- [UI Plugins](ui.md) - Interface and appearance plugins
