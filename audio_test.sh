#!/system/bin/sh
speaker_test()
{
tinymix "MI2S_RX Channels"  Two
tinymix "RX1 MIX1 INP1" RX1
tinymix "RX2 MIX1 INP1" RX2
tinymix "RDAC2 MUX" RX2
tinymix "HPHL" "Switch"
tinymix "HPHR" "Switch"
tinymix "Ext Spk Switch" "On"
tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
tinyplay /vendor/112.wav -d 0
}

stop_speaker_test()
{
tinymix "MI2S_RX Channels"  0
tinymix "RX1 MIX1 INP1" 0
tinymix "RX2 MIX1 INP1" 0
tinymix "RDAC2 MUX" 0
tinymix "HPHL" 0
tinymix "HPHR" 0
tinymix "Ext Spk Switch" "On"
tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
}

main_mic_loop_test()
{
	echo 'mic loop test'
	tinymix 'LOOPBACK Mode' 'ENABLE'
	tinymix 'DEC1 MUX' 'ADC1'
	tinymix 'RDAC2 MUX' 'RX1'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX1 MIX1 INP1' 'IIR1'
	tinymix 'RX1 Digital Volume' '120'
	tinymix 'EAR_S' 'Switch'
	tinymix 'Loopback MCLK' 'ENABLE'
}

stop_main_mic_loop_test(){
	echo 'stop mic loop test'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'EAR_S' 'ZERO'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'Loopback MCLK' 'DISABLE'
	tinymix 'LOOPBACK Mode' 'DISABLE'
}

sub_mic_loop_test()
{
	echo 'sub-mic loop test'
	tinymix 'LOOPBACK Mode' 'ENABLE'
	tinymix 'DEC1 MUX' 'ADC3'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'RDAC2 MUX' 'RX1'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX1 MIX1 INP1' 'IIR1'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'EAR_S' 'Switch'
	tinymix 'Loopback MCLK' 'ENABLE'
}

stop_sub_mic_loop_test(){
	echo 'stop sub-mic loop test'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'EAR_S' 'ZERO'
	tinymix 'Loopback MCLK' 'DISABLE'
	tinymix 'LOOPBACK Mode' 'DISABLE'
}


headset_mic_loop_test()
{
	echo 'headset_mic_loop_test'
	tinymix 'LOOPBACK Mode' 'ENABLE'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX1 MIX1 INP1' 'IIR1'
	tinymix 'RX2 MIX1 INP1' 'IIR1'
	tinymix 'RDAC2 MUX' 'RX2'
	tinymix 'HPHL' 'Switch'
	tinymix 'HPHR' 'Switch'
	tinymix "ADC2 Volume" 40
	tinymix "DEC1 Volume" 72
#	tinymix 'RX1 Digital Volume' '88'
#	tinymix 'RX2 Digital Volume' '88'
	tinymix 'Loopback MCLK' 'ENABLE'
}

stop_headset_mic_loop_test(){
	echo 'stop_headset_mic_loop_test'
	tinymix 'LOOPBACK Mode' 'DISABLE'
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'RX2 MIX1 INP1' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'HPHL' 'ZERO'
	tinymix 'HPHR' 'ZERO'
	tinymix "ADC2 Volume" 4
	tinymix "DEC1 Volume" 84
	tinymix 'Loopback MCLK' 'DISABLE'
}


if [ $1 == 'mic' ];then
	main_mic_loop_test
fi
if [ $1 == 'stop-mic' ];then
	stop_main_mic_loop_test
fi
if [ $1 == 'sub-mic' ];then
	sub_mic_loop_test
fi
if [ $1 == 'stop-sub-mic' ];then
	stop_sub_mic_loop_test
fi

if [ $1 == 'headset-mic' ];then
	headset_mic_loop_test
fi

if [ $1 == 'stop-headset-mic' ];then
	stop_headset_mic_loop_test
fi

if [ $1 == 'headset-left' ];then
        echo $$ > /data/audio_test.pid
	tinymix "Ext Spk Switch" Off
	tinymix "MI2S_RX Channels"  Two
	tinymix "RX1 MIX1 INP1" RX1
	tinymix "RX2 MIX1 INP1" RX2
	tinymix "RDAC2 MUX" RX2
	tinymix "HPHL" Switch
	tinymix "HPHR" ZERO
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
	while [ 1 ];do
		tinyplay /vendor/112.wav -d 0
	done
fi

if [ $1 == 'headset-left-stop' ];then
        if [ -f /data/audio_test.pid ];then
	   pid=`cat /data/audio_test.pid`
	   kill -9 $pid
	   rm /data/audio_test.pid
	fi
	tinymix "MI2S_RX Channels" One 
	tinymix "RX1 MIX1 INP1" 0
	tinymix "RX2 MIX1 INP1" 0
	tinymix "RDAC2 MUX" 0
	tinymix "HPHL" 0
	tinymix "HPHR" 0
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
fi

if [ $1 == 'headset-right' ];then
        echo $$ > /data/audio_test.pid
	tinymix "Ext Spk Switch" Off
	tinymix "MI2S_RX Channels"  Two
	tinymix "RX1 MIX1 INP1" RX1
	tinymix "RX2 MIX1 INP1" RX2
	tinymix "RDAC2 MUX" RX2
	tinymix "HPHL" 0
	tinymix "HPHR" Switch
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
	while [ 1 ];do
		tinyplay /vendor/112.wav -d 0
	done
fi

if [ $1 == 'headset-right-stop' ];then
        if [ -f /data/audio_test.pid ];then
	   pid=`cat /data/audio_test.pid`
	   kill -9 $pid
	   rm /data/audio_test.pid
	fi
	tinymix "MI2S_RX Channels" One 
	tinymix "RX1 MIX1 INP1" 0
	tinymix "RX2 MIX1 INP1" 0
	tinymix "RDAC2 MUX" 0
	tinymix "HPHL" 0
	tinymix "HPHR" 0
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
fi
