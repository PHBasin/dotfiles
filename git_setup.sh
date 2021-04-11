export GITHUB_USERNAME=PHBasin
git config --global user.email "pierre-henri.basin@orange.fr"
git config --global user.name "PHBasin"
git config --global core.editor "vim"

echo "Add the following key to your GitHub account (https://github.com/settings/ssh/new): "
mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C "pierre-henri.basin@orange.fr"
cat ~/.ssh/id_ed25519.pub

echo "Check that this step is completed, in the terminal run this: ssh -T git@github.com"

echo "👌 Awesome, all set."
