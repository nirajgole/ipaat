# Do the following tasks:
# ● Create a git working directory with feature1.txt and feature2.txt in the master branch
# ● Create 3 branches develop, feature1 and feature2
# ● In develop branch create develop.txt, do not stage or commit it
# ● Stash this file, and checkout to feature1 branch
# ● Create new.txt file in feature1 branch, stage and commit this file
# ● Checkout to develop, unstash this file and commit
# Please submit all the git commands used to do the above steps


source: https://github.com/nirajgole/assignment_1

touch feature1.txt feature2.txt
git checkout -b develop
git checkout -b feature2
git checkout -b feature1
git switch develop
touch develop.txt
git stash
git switch feature1
touch new.txt
git add new.txt
git commit -m "added new file"
git switch develop
git stash pop
git add develop.txt
git commit -m "added develop file"