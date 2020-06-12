import telepot
import glob
import os
import time
import sys

recname = sys.argv[1]
bot = telepot.Bot('<Secret_botapi_token>')

#list_of_files = glob.glob('/home/pi/Raak_Raw_Recordings/*.h264')
list_of_files = glob.glob('/NAS/BeeNas/scripts/BeeDataProcessing/telegramcamerabot/*.h264')
latest_file = max(list_of_files, key=os.path.getctime)
lastfile_timestamp = os.path.getctime(latest_file)
now = time.time()
td = now - lastfile_timestamp
td_min = str(int(td/60))

if td > 660:
    bot.sendMessage('<chat or channel id>', "Recording " + recname +": The last file was created: " + td_min + " min ago. Perhaps the camera has crashed should be check for a crash?" )

