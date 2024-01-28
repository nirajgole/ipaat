#download dataset zip folder to shared mounted folder on vm
sudo yum install -y unzip
unzip linux_mod6_dataset.zip
#print name and year
awk -F "," 'BEGIN{ORS="\n\n"}{print $2,$4}' linux_mod6_dataset.csv
#print records between 200-210
awk -F ',' 'BEGIN{OFS="--"} NR > 200 && NR <= 210 {print $1,$2,$4}' linux_mod6_dataset.csv
# all the games released in year 2005 and rows between 100 to 500
awk -F ',' 'BEGIN{OFS="--"} NR > 100 && NR <= 500 && $4==2005 {print $1,$2,$4}' linux_mod6_dataset.csv

#shared folder local to vm
sudo mount -t vboxsf local_folder_name vm_folder_name