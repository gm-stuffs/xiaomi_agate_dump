#disable safe volume
service call audio 74 s16 ''
#set stream volume
service call audio 10 i32 3 i32 12

playback_fct
