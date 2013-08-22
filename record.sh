rm output.mkv
(sleep 2; jack_connect ChucK:outport\ 0 ffmpeg:input_1) &
(sleep 2; jack_connect ChucK:outport\ 1 ffmpeg:input_2) &
ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -r 30 -s 1920x1080 -i ${DISPLAY}.0 -acodec pcm_s16le -vcodec libx264 -vpre faster -threads 0 -y output.mkv
