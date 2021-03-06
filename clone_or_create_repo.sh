#!/bin/bash
GITHUB_TOKEN=$1
REPO_NAME=$2
ORG_NAME=$3
GITHUB_USER=$4

if git clone https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$ORG_NAME/$REPO_NAME.git
then 
    echo "Repo already exists."
else 
    git config --global user.name $GITHUB_USER
    gh repo create $ORG_NAME/$REPO_NAME --public --confirm
    mkdir ./$REPO_NAME
    cd ./$REPO_NAME
    echo "# "$REPO_NAME >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$ORG_NAME/$REPO_NAME.git
    git push -u origin main
    cd ..
    echo "Repo has been created"
fi