# Enhanced Navigation: Flit + Leap

**→ Cross-Mode Compatible**: Works in both standalone Neovim and VSCode.

This guide covers the powerful motion system provided by Flit.nvim and Leap.nvim working together.

## 🔗 How They Work Together

- **Flit.nvim**: Enhances the basic `f`, `F`, `t`, `T` motions with labeled targets
- **Leap.nvim**: Provides the underlying jump system and adds `s`, `S`, `gs` motions
- **Together**: They create a comprehensive navigation system for precise text movement

## ★ Flit.nvim - Enhanced f/t Motions

### Purpose
Flit enhances Vim's basic `f`, `F`, `t`, `T` motions with:
- **Labeled targets** - See exactly where you'll jump
- **Clever repeat** - Smart `;` and `,` behavior
- **Multiline support** - Jump across lines
- **Visual mode integration** - Extend selections

### Keybindings

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `f` | Normal | Jump forward to character | Jump to next occurrence of character |
| `F` | Normal | Jump backward to character | Jump to previous occurrence of character |
| `t` | Normal | Jump forward to before character | Jump to just before next occurrence |
| `T` | Normal | Jump backward to before character | Jump to just before previous occurrence |
| `f` | Visual | Extend selection to character | Extend selection to next occurrence |
| `F` | Visual | Extend selection to character | Extend selection to previous occurrence |
| `;` | Normal | Repeat last motion | Repeat the last f/F/t/T motion |
| `,` | Normal | Repeat motion backward | Repeat the last motion in opposite direction |

### Getting Started with Flit

1. **Basic jumping**: Press `f` followed by any character to jump to the next occurrence
2. **Backward jumping**: Press `F` followed by any character to jump to the previous occurrence
3. **Before character**: Press `t` to jump to just before the next occurrence, `T` for previous
4. **Visual mode**: Use `V` to select lines, then `f`/`F` to extend selection to a character
5. **Repeat motions**: Use `;` to repeat the last motion, `,` to repeat in opposite direction

### Visual Guide
When you press `f` followed by a character, you'll see labeled targets appear:
```
Press 'f' then 'e':
H e l l o   w o r l d
  ^   ^
  a   b
```
Press `a` to jump to the first `e`, or `b` to jump to the second `e`.

## ★ Leap.nvim - 2-Character Jumping

### Purpose
Leap provides powerful 2-character jumping with:
- **Cross-line jumping** - Jump between different lines
- **Window-wide search** - Jump anywhere in the visible area
- **Multi-target selection** - Jump to multiple targets at once
- **Backdrop highlighting** - See all possible jump targets

### Keybindings

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `s` | Normal | Jump to 2 characters | Jump to any 2 characters in visible area |
| `S` | Normal | Jump to 2 characters in line | Jump to any 2 characters in current line |
| `gs` | Normal | Jump to 2 characters in window | Jump to any 2 characters in entire window |
| `s` | Visual | Extend selection to 2 characters | Extend selection to 2-character target |
| `S` | Visual | Extend selection to 2 characters | Extend selection to 2-character target in line |
| `;` | Normal | Repeat last leap | Repeat the last leap motion |
| `,` | Normal | Repeat leap backward | Repeat the last leap motion backward |

### Getting Started with Leap

1. **Basic jumping**: Press `s` followed by any 2 characters to jump anywhere in the visible area
2. **Line jumping**: Press `S` followed by any 2 characters to jump in the current line
3. **Window jumping**: Press `gs` followed by any 2 characters to jump anywhere in the window
4. **Visual mode**: Use `V` to select lines, then `s`/`S` to extend selection to 2 characters
5. **Repeat motions**: Use `;` to repeat the last leap, `,` to repeat backward

### Visual Guide
When you press `s` followed by 2 characters, you'll see labeled targets appear:
```
Press 's' then 'el':
H e l l o   w o r l d
  ^ ^
  a b
```
Press `a` to jump to the first `el`, or `b` to jump to the second `el`.

## → When to Use Which

### Use Flit (f/t motions) when:
- You want to jump to a **single character**
- You're working **within a line** or **nearby lines**
- You want **precise control** over character positioning
- You're used to **traditional Vim motions**

### Use Leap (s/S/gs motions) when:
- You want to jump to **2 characters** for more precision
- You need to jump **across multiple lines**
- You want to see **all possible targets** at once
- You're working with **longer text** or **complex layouts**

## ⚙ Configuration

### Flit Configuration
```lua
require("flit").setup({
  labeled_modes = "nv",  -- Enable labels in normal and visual modes
  clever_repeat = true,  -- Enable clever repeat behavior
  multiline = true,      -- Enable multiline support
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },  -- Key mappings
})
```

### Leap Configuration
```lua
require("leap").setup({
  case_sensitive = false,  -- Case insensitive search
  safe_labels = { "f", "d", "s", "j", "k", "l", "h", "o", "w", "e", "b", "u", "y", "v", "r", "g", "t", "c", "x", "z", "a", "q", "p", "n", "m" },
  labels = { "f", "d", "s", "j", "k", "l", "h", "o", "w", "e", "b", "u", "y", "v", "r", "g", "t", "c", "x", "z", "a", "q", "p", "n", "m" },
})
```

## 🔧 Advanced Tips

### Combining Motions
- Use **Flit** for precise single-character positioning
- Use **Leap** for quick 2-character jumping
- Use **repeat motions** (`;` and `,`) to quickly navigate between similar targets

### Visual Mode Workflow
1. **Select lines** with `V`
2. **Extend selection** with `f`/`F` (Flit) or `s`/`S` (Leap)
3. **Repeat** with `;` or `,` to extend further

### Performance Tips
- **Flit** is faster for single-character jumps
- **Leap** is more powerful for complex navigation
- Use **multiline = false** in Flit if you only work within lines

## 🆘 Troubleshooting

### Common Issues
- **Labels not appearing**: Check that `labeled_modes` includes the mode you're in
- **Motions not working**: Ensure both plugins are loaded correctly
- **Slow performance**: Try disabling `multiline` in Flit or reducing `max_phase_one_targets` in Leap

### Debug Commands
```vim
:lua print("Flit loaded:", pcall(require, 'flit'))
:lua print("Leap loaded:", pcall(require, 'leap'))
:checkhealth
```

## 📚 Further Reading

- [Flit.nvim GitHub](https://github.com/ggandor/flit.nvim)
- [Leap.nvim GitHub](https://github.com/ggandor/leap.nvim)
- [Vim Motions Guide](https://vim.fandom.com/wiki/Moving_around)
- [Complete Keymap Reference](keymaps.md#enhanced-navigation)

---

**Happy navigating!** ★✨
