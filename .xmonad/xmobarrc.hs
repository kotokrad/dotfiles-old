Config {
         font = "xft:FantasqueSansMono Nerd Font:size=10:bold:antialias=true"
       , additionalFonts = [ "xft:FontAwesome:size=11" ]
       , allDesktops = True
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = TopW L 100
       , textOffset = 13
       , textOffsets = [14]
       , commands = [ Run StdinReader

                    , Run Alsa "default" "Master"
                          [ "-t", "<status> <volume>%"
                          , "-H", "60"
                          , "--"
                          , "--on", ""
                          , "--off", "婢 "
                          , "--onc", "#98971a"
                          , "--offc", "#7c6f64"
                          , "--lows", "奄 "
                          , "--mediums", "奔 "
                          , "--highs", "墳 " ]

--                     , Run CoreTemp
--                           [ "-t", "<fc=#98971a><fn=1></fn></fc> <core0>°"
--                           , "-L", "30"
--                           , "-H", "75"
--                           , "-l", "lightblue"
--                           , "-n", "#bbc2cf"
--                           , "-h", "#cc241d" ]
--                           50

                    , Run Cpu
                          [ "--template", "<fc=#cc241d><fn=1></fn></fc> <total>%"
                          , "--Low","3"
                          , "--High","50"
                          , "--low","#bbc2cf"
                          , "--normal","#bbc2cf"
                          , "--high","#cc241d" ]
                          50

                    , Run Memory
                          ["-t","<fc=#d79921><fn=1></fn></fc> <usedratio>%"
                          ,"-H","80"
                          ,"-L","10"
                          ,"-l","#bbc2cf"
                          ,"-n","#bbc2cf"
                          ,"-h","#cc241d" ]
                          50

                    , Run DiskU
                          [("/", "<fc=#458588><fn=1></fn></fc> <free>")]
                          [ "-L", "5"
                          , "-m", "1"
                          , "-p", "3"
                          , "--normal", "#bbc2cf"
                          , "--low", "#cc241d" ]
                          20

                    , Run Date "%a %b %_d %I:%M" "date" 300

                    , Run Kbd [("us", "US"), ("ru", "RU")]

                    , Run Com "/home/kotokrad/.xmonad/padding-icon.sh" ["panel"] "trayerpad" 10

                    -- , Run BatteryP       [ "BAT0" ]
                    --                      [ "--template" , "<fc=#B1DE76><fn=1></fn></fc> <acstatus>"
                    --                      , "--Low"      , "10"        -- units: %
                    --                      , "--High"     , "80"        -- units: %
                    --                      , "--low"      , "#fb4934" -- #ff5555
                    --                      , "--normal"   , "#bbc2cf"
                    --                      , "--high"     , "#98be65"

                    --                      , "--" -- battery specific options
                    --                                -- discharging status
                    --                                , "-o"   , "<left>% (<timeleft>)"
                    --                                -- AC "on" status
                    --                                , "-O"   , "<left>% (<fc=#98be65>Charging</fc>)" -- 50fa7b
                    --                                -- charged status
                    --                                , "-i"   , "<fc=#98be65>Charged</fc>"
                    --                      ] 50

                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %alsa:default:Master% <fc=#7c6f64></fc> %cpu% <fc=#7c6f64></fc> %memory% <fc=#7c6f64></fc> %disku% <fc=#7c6f64></fc> %kbd% <fc=#7c6f64></fc> %date% %trayerpad%"
       }
