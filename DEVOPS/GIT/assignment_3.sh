# You have been asked to:
# ● Create a git working directory, with the following branches
# ○ Develop
# ○ F1
# ○ f2
# ● In the master branch, commit main.txt file
# ● Put develop.txt in develop branch, f1.txt and f2.txt in f1 and f2 respectively
# ● Push all these branches to github
# ● On local delete f2 branch
# ● Delete the same branch on github as well

mkdir assignment_3
git chekout -b Develop
git chekout -b F1
git chekout -b f2
git switch main
touch main.txt
git add main.txt
git commit -m "added main file"
git switch develop
touch develop.txt
git add .
git commit -m "added develop file"
git push --set-upstream origin develop
git switch f1
touch f1.txt
git add .
git commit -m "added f1 file"
git push --set-upstream origin f1
git switch f2
touch f2.txt
git add .
git commit -m "added f2 file"
git push --set-upstream origin f2
git swith main
git branch
git branch -d feature2
git push -d origin feature2