- When asked to commit our changes to git, try to make the commit concise to a single message if possible.
- When commiting, don't mention claude code.
- When commiting never add created by claude code or something

## Dotfiles Sync

This configuration is managed in the dotfiles repository at `~/.dotfiles/claude/`.

When creating custom commands, skills, or other Claude Code configurations, they will automatically be in the dotfiles repo since `~/.claude/` is symlinked to `~/.dotfiles/claude/.claude/`.

To sync these to other machines, just commit them:
```bash
cd ~/.dotfiles
git add claude/
git commit -m "Add custom Claude configurations"
git push
```