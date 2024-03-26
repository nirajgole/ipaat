# ● Put master.txt on master branch, stage and commit
# ● Create 3 branches: public1, public2 and private
# ● Put public1.txt on public 1 branch, stage and commit
# ● Merge public 1 on master branch
# ● Merge public 2 on master branch
# ● Edit master.txt on private branch, stage and commit
# ● Now update branch public 1 and public 2 with new master code in private
# ● Also update new master code on master
# ● Finally update all the code on the private branch

touch master.txt
git add master.txt
git commit -m "added master file"
git checkout -b public1
git checkout -b public1
git checkout -b public1
git switch public1
touch public1.txt
git add .
git commit -m "added public1 file"
git switch public2
touch public2.txt
git add .
git commit -m "added public2 file"
git switch private
touch private.txt
git add .
git commit -m "added private file"
git switch public1
git merge main
git switch public2
git merge main
git switch main
echo "this file is updated" >> master.txt
git add .
git commit -m "updated file"
git switch public1
git merge main
git switch public2
git merge main
git switch main
git merge public1
git merge public2
git switch private
git merge main
git switch main
git add .
git commit -m "updated all code"
git push origin main