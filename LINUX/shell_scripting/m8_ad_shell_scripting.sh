#open firefox
firefox &
#get PID
#ps
#top
pgrep firefox
#kill/terminate firefox
kill -9 [PID]


#monitor folder using inotify
sudo yum install -y inotify-tools

inotifywait -m ./share -e create -e moved_to --format '%w%f' >> ./output.log