#!/system/bin/sh

lib_path="./XYZ"

echo "XYZ GAMING ROOT PROJECT"
echo "-  Select the package:"
echo "1. GLOBAL    - com.tencent.ig"
echo "2. KOREA     - com.pubg.krmobile"
echo "3. VIETNAM   - com.vng.pubgmobile"
echo "4. INDIA    - com.pubg.imobile"
echo "0. Exit"

echo "Enter your choice (0-4): "
read user_choice

case $user_choice in
    1)
        __package="com.tencent.ig"
        ;;
    2)
        __package="com.pubg.krmobile"
        ;;
    3)
        __package="com.vng.pubgmobile"
        ;;
    4)
        __package="com.pubg.imobile"
        ;;
    0)
        echo "Exiting the script."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

matching_directories=($(find /data/app/ -type d -name "*$__package*"))

if [ ${#matching_directories[@]} -gt 0 ]; then
    for matching_directory in "${matching_directories[@]}"; do
        target_directory="$(echo "$matching_directory" | sed 's/\(.*$__package[^\/]*\).*/\1/')"
        
        echo "Target package: $__package"
        cp "$lib_path" "$target_directory/lib/arm/libmarsxlog.so" 
        copy_status=$?
        
        if [ $copy_status -eq 0 ]; then
            chmod 755 "$target_directory/lib/arm/libmarsxlog.so"
            echo "Cheat activated successfully, please run the game if it doesn't start automatically in the next 5 seconds..."
        else
            echo "Error ! Cheat Not Activated"
        fi
		sleep 5
		am start -n "$__package/com.epicgames.ue4.SplashActivity"
    done
else
    echo "Error ! Cheat Not Activated"
fi