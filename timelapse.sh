if [ "$#" -lt 2 ]
then
  echo "Usage $0 DELAY_IN_SECONDS NUM_CAPTURES"
  exit 1
fi

rm -rf /tmp/timeLapseData
mkdir /tmp/timeLapseData

echo "Click Window to capture"
WINDOW_ID=`xwininfo | grep "Window id" | cut -f 4 -d " "`
COUNT=0;

while [ $COUNT -lt $2 ]
do
   echo "Progress: $COUNT/$2"
   sleep $1
   import -silent -window $WINDOW_ID /tmp/timeLapseData/capture$COUNT.jpg
   COUNT=`expr $COUNT + 1`
done
echo "Completed capture, converting to video"

if [ "$#" -gt 2 ]
then
  ffmpeg -y -i /tmp/timeLapseData/capture%1d.jpg -i $3 -b 9800000 timeLapse.mpg
else
  ffmpeg -y -i /tmp/timeLapseData/capture%1d.jpg -b 9800000 timeLapse.mpg
fi

