#setup git remote
git config --global user.email "your_email@example.com"
git config --global --list
#create commit
git add .
git commit -m "first commit"
##create repo + push
gh repo create my-project --public --source=. --push
###list
git remote -v
####open url 
gh repo view --web

# if termux,shell = environment :/data/data/alsultan.shell/rootfs
## edit : git config --global init.defaultBranch main

## set commad ex: git add . && git commit -m "update" && git push
