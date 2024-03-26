# Based on what you have learnt in the class, do the following steps:
# ● Create a new folder
# ● Put the following files in the folder
#   ○ Code.txt
#   ○ Log.txt
#   ○ Output.txt
# ● Stage the Code.txt and Output.txt files
# ● Commit them
# ● And finally push them to github

#performed on GCP cloud-shell/ hadoop
#gcp editor mode (user-friendly) can be used

mkdir assignment_1
cd assignment_1
touch log.txt code.txt output.txt

git init
git status
git add code.txt output.txt
git branch -m main

git config user.email "nirajgp777@gmail.com"
git config user.name "nirajgole"

git commit -m "added code and output files"

#select SSH as per github new changes for authentication
git remote add origin git@github.com:nirajgole/assignment_1.git
git remote -v
ssh-keygen -t rsa -b 4096 -C "nirajgp777@gmail.com"
#after running above command few prompts will appear, there put file name (id_rsa) and paraphrase to save
cat ~/.ssh/id_rsa.pub
#copy output of above command and paste in respective github SSH keys account
git push origin main

#check output at following repo
https://github.com/nirajgole/assignment_1