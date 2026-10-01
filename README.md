# dotfiles

Configuration Zsh / Git / Vim pour Ubuntu & Debian (WSL inclus).

## 🚀 Installation rapide

```bash
curl -fsSL https://raw.githubusercontent.com/PHBasin/dotfiles/main/bootstrap.sh | bash
```

Ou depuis un clone existant :

```bash
./install.sh
```

Le script est idempotent : il peut être relancé sans risque.

## Ce que fait `install.sh`

1. Met à jour le système et installe les paquets de base (`git`, `zsh`, `vim`, `jq`…).
2. Installe [Oh My Zsh](https://ohmyz.sh/) + `zsh-autosuggestions` et `zsh-syntax-highlighting`, et passe Zsh en shell par défaut.
3. Crée les liens symboliques `~/.<fichier>` → `dotfiles/<fichier>`.
   Les fichiers existants sont **sauvegardés** dans `~/.dotfiles-backup/<date>/`, jamais supprimés.
4. Installe [pyenv](https://github.com/pyenv/pyenv) et Python (`PYTHON_VERSION=3.12.7 ./install.sh` pour changer de version).

## Contenu

| Fichier                         | Lien                    |
| ------------------------------- | ----------------------- |
| `zshrc`                         | `~/.zshrc`              |
| `zprofile`                      | `~/.zprofile`           |
| `aliases`                       | `~/.aliases`            |
| `gitconfig`                     | `~/.gitconfig`          |
| `vim/`                          | `~/.vim`                |
| `windows-terminal/settings.json` | à copier manuellement dans Windows Terminal |

## Personnalisation locale

Ce qui est propre à une machine (secrets, tokens, `export` spécifiques) va dans
`~/.zshrc.local`, chargé automatiquement et non versionné.
