# ● Create a gitflow workflow architecture on git
# ● Create all the required branches
# ● Starting from the feature branch, push the branch to the master, following the
# architecture
# ● Push a urgent.txt on master using hotfix

git switch main
git branch develop
git branch feature1
git branch feature2
git switch feature1
git add .
git commit -m ""
git merge develop
git switch feature2
git add .
git commit -m ""
git merge develop
git switch develop
git merge feature1
git merge feature2
git merge main
git switch main
git merge develop
git checkout -b hotfix
touch hotfix.sh
git add .
git commit -m "added hotfix"
git merge main
git switch main
git merge hotfix
git switch develop
git merge main
git switch feature1
git merge develop
git switch feature2
git merge develop

