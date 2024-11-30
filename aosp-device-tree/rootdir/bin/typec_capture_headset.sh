VOCALTRACT=$1

function enable_headset_mic
{
    echo "enabling headset mic"
    tinymix 'Mic_Type_Mux_0' 'DCC'
    tinymix 'Mic_Type_Mux_1' 'VOW_DCC'
    tinymix 'UL1_CH1 ADDA_UL_CH1' 1
    tinymix 'UL1_CH2 ADDA_UL_CH2' 1
    tinymix 'MISO0_MUX' 'UL1_CH1'
    tinymix 'MISO1_MUX' 'UL1_CH1'
    tinymix 'ADC_L_Mux' 'Left Preamplifier'
    tinymix 'PGA_L_Mux' 'AIN1'
}

function disable_headset_mic
{
    echo "disabling headset mic"
    tinymix 'Mic_Type_Mux_0' 'Idle'
    tinymix 'UL1_CH1 ADDA_UL_CH1' 0
    tinymix 'UL1_CH2 ADDA_UL_CH2' 0
    tinymix 'ADC_L_Mux' 'Idle'
    tinymix 'ADC_R_Mux' 'Idle'
    tinymix 'PGA_L_Mux' 'None'
    tinymix 'PGA_R_Mux' 'None'
}

AudioSetParam SET_LOOPBACK_TYPE=0,0

#This cmd can bypass all the algo in hifi3(UL and DL)
AudioSetParam SET_AURISYS_ON=0
# setup
enable_headset_mic

tinymix 'Audio_PGA1_Setting' 3
tinymix 'Audio_PGA2_Setting' 3
tinymix 'Handset_PGA_GAIN' 0

sleep 0.2

# start recording
tinycap /data/test1_$VOCALTRACT.wav -D 0 -d 10 -c 2 -r 48000 -b 16 -p 1024 -n 8 -T 3

disable_headset_mic

AudioSetParam SET_AURISYS_ON=1
