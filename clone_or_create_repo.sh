#!/bin/bash
GITHUB_TOKEN=$1
REPO_NAME=$2
if git clone https://nwkhteam:$GITHUB_TOKEN@github.com/Nowhere-Know-How/$REPO_NAME.git
then 
    echo "Repo already exists."
else 
    gh repo create Nowhere-Know-How/$REPO_NAME --public --confirm
    cd ./$REPO_NAME
    echo "# "$REPO_NAME >> README.md
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git push -u origin main
    cd ..
fi