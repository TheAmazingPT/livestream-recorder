# Audio Livestream Recorder
I have a few favorite radio shows, which i like to archive.
This tool helps me to record the live internet stream, convert it to mp3 and
finally to upload this file onto my private cloud storage.

### Prerequisites
- VLC (cvlc)

### Add a new stream
I am using VLC for recording internet streams.

See this guide for more info:
https://wiki.videolan.org/Documentation:Streaming_HowTo_New/

Steps:
- Create a file for the new stream, take a look at my files
- Update `utils/crontab` for every new file you create

### Upload to a cloud storage
I am running Nextcloud, so this is the only provider I keep in this repository.
At the end of every stream script, you see that i call my sync-to-nextcloud
utility. You need to write an utility on your own, if you need something else.

If you like to reuse my Nextcloud script, keep in mind the I expect a certain
running setup on the system.
You need the following installed and configured:
- rclone
- Private Nextcloud backend configured in rclone

### Deployment
There is no deployment per se. I am cloning this repository onto my server
and pull every update on there.
When a new stream was added, you might need to update the user crontab on the
server.

```sh
crontab -u USERNAME utils/crontab
```

### Legal warning
You are responsible whether it is allowed for you to record internet streams in
your jurisdiction. Most often **it is illegal to redistribute** the recordings!
So if you record a livestream, keep it for yourself.
