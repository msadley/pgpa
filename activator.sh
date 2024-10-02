uadb_port="5555"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# $DIR/adb kill-server
# $DIR/adb disconnect

function detect() {
    if [ `$DIR/adb devices | grep "unauthorized" | wc -l` -ge 1 ]; then
        echo "Phone unauthorized. Please check your phone for the authorization prompt."
        return
    fi

    $DIR/adb root
    if [ $? -eq 1 ]; then
        echo "Phone not found. Ensure USB Debugging is enabled and the device is connected."
        return
    fi

    inject
}

function inject() {
    $DIR/adb shell mkdir /data/local/tmp/2
    $DIR/adb push $DIR/scripts/* /data/local/tmp/2/
    $DIR/adb shell sh /data/local/tmp/2/inject2.sh
    echo "Activation completed. Please launch APP Panda Gamepad Pro or Panda Mouse Pro on your phone."
    exit
}

detect

