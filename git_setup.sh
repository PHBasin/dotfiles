echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

export GITHUB_USERNAME=$full_name
git config --global user.email $email
git config --global user.name $full_name
git config --global core.editor "vim"

echo "Add the following key to your GitHub account (https://github.com/settings/ssh/new): "
mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C "basinpierrehenri@gmail.com"
cat ~/.ssh/id_ed25519.pub

echo "Check that this step is completed, in the terminal run this: ssh -T git@github.com"

git add .
git commit --message "My identity in the gitconfig"
git push origin master

echo "👌 Awesome, all set."
