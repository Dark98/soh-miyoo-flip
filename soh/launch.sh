#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}


# Set variables
GAMEDIR=$(cd "$(dirname "$0")" && pwd)

# Exports
export LD_LIBRARY_PATH="$GAMEDIR/libs":$LD_LIBRARY_PATH
export SDL_GAMECONTROLLERCONFIG_FILE="./gamecontrollerdb.txt"
#export SDL_GAMECONTROLLERCONFIG=$sdl_controllerconfig
export PATCHER_FILE="$GAMEDIR/assets/otrgen"
export PATCHER_GAME="$(basename "${0%.*}")" # This gets the current script filename without the extension

# CD and set permissions
cd $GAMEDIR
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Close the menu if open
sed -i 's/"Menu": *1/"Menu": 0/' shipofharkinian.json

# -------------------- BEGIN FUNCTIONS --------------------

# Check imgui.ini and modify if needed
imgui_reset() {
    input_file="imgui.ini"
    temp_file="imgui_temp.ini"
    skip_section=0
    # Loop through each line in the input file
    while IFS= read -r line; do
        # Check if the line is a window header
        if [[ "$line" =~ ^\[Window\]\[Main\ Game\] || "$line" =~ ^\[Window\]\[Main\ -\ Deck\] ]]; then
            skip_section=1  # Set the flag to skip modifications for this section
        elif [[ "$line" =~ ^\[Window\] ]]; then
            skip_section=0  # Reset the flag for other windows
        fi

        # Modify Pos and Size only if the current section is not skipped
        if [[ $skip_section -eq 0 ]]; then
            if [[ "$line" =~ ^Pos=.* ]]; then
                echo "Pos=30,30" >> "$temp_file"
            elif [[ "$line" =~ ^Size=.* ]]; then
                echo "Size=400,300" >> "$temp_file"
            else
                echo "$line" >> "$temp_file"
            fi
        else
            # If skipping, write the line unchanged
            echo "$line" >> "$temp_file"
        fi
    done < "$input_file"

    # Replace the original file with the modified one
    mv "$temp_file" "$input_file"
}

otr_check() {
if [ ! -f "oot.otr" ] || [ ! -f "oot-mq.otr" ]; then
    # Ensure we have a rom file before attempting to generate otr
    if ls *.*64 1> /dev/null 2>&1; then
        $GAMEDIR/assets/otrgen
    else
        echo "Missing ROM files! Can't generate otr!"
    fi
    
    # Check if OTR files were generated
    if [ ! -f "oot.otr" ] && [ ! -f "oot-mq.otr" ]; then
        echo "No otr files, can't run the game!"
        exit 1
    fi
fi
}

# --------------------- END FUNCTIONS ---------------------

# Perform functions
otr_check

if [ -f "imgui.ini" ]; then
    imgui_reset
fi

# Run the game
./gptokeyb "soh.elf" -c "soh.gptk" & 
./soh.elf

# Cleanup
rm -rf "$GAMEDIR/logs/"
