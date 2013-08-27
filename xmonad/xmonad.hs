
import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map as M


myTerminal      = "/usr/bin/gnome-terminal"
myModMask       = mod1Mask
myWorkspaces    = ["1:main","2:web","3:mail","4:im","5:vm"]
                -- ++ map show [6..9]

myBorderWidth        = 2
myNormalBorderColor  = "black"
myFocusedBorderColor = "red"
myFocusFollowsMouse   = True

xmobarTitleColor            = "green"
xmobarCurrentWorkspaceColor = "red"


-- Keybindings
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask,  xK_c),      kill)
    , ((modMask,                xK_space),  sendMessage NextLayout)
    , ((modMask .|. shiftMask,  xK_space),  setLayout $ XMonad.layoutHook conf)
    , ((modMask,                xK_n),      refresh)
    , ((modMask,                xK_Tab),    windows W.focusDown)
    , ((modMask,                xK_j),      windows W.focusDown)
    , ((modMask,                xK_k),      windows W.focusUp)
    , ((modMask,                xK_m),      windows W.focusMaster)
    , ((modMask,                xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask,  xK_j),      windows W.swapDown)
    , ((modMask .|. shiftMask,  xK_k),      windows W.swapUp)
    , ((modMask,                xK_h),      sendMessage Shrink)
    , ((modMask,                xK_l),      sendMessage Expand)
    , ((modMask,                xK_t),      withFocused $ windows . W.sink)
    , ((modMask,                xK_comma),  sendMessage (IncMasterN 1))
    , ((modMask,                xK_period), sendMessage (IncMasterN (-1)))
    , ((modMask,                xK_q),      restart "xmonad" True)
    , ((modMask .|. shiftMask,  xK_q),
            spawn "gnome-session-quit --power-off")
    , ((modMask,                xK_F1),
            spawn "gvim +/Keybindings ~/.xmonad/xmonad.hs") -- keybinding help
    --, ((modMask,                  xK_y),      focusUrgent)
    ]
    ++
    -- Shortcuts Mask+1 .. Mask+9 to switch workspace
    [ ((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
    -- Shortcuts Mask+w & Mask+e to switch to prev/next workspace
    [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_w, xK_e] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    {-++
    -- Switch to screen 1, 2 or 3 with Mask+w, Mask+e or Mask+r
    [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    -}
    ++
    -- Application starters
    [ ((modMask .|. shiftMask, xK_Return),  spawn $ XMonad.terminal conf)
    , ((modMask, xK_w), spawn "chromium-browser")
    , ((modMask, xK_e), spawn "thunderbird")
    , ((modMask, xK_v), spawn "gvim")
    , ((modMask, xK_p), spawn "dmenu_path | yeganesh -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC'")
    ]


-- Mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w   >> mouseMoveWindow w
                                            >>  windows W.shiftMaster))
    , ((modMask, button2), (\w -> focus w   >> windows W.shiftMaster))
    , ((modMask, button3), (\w -> focus w   >> mouseResizeWindow w
                                            >> windows W.shiftMaster))
    ]


-- Window rules
myManageHook = composeAll
    [ resource  =? "desktop_window" --> doIgnore
    , className =? "stalonetray"    --> doIgnore
    , className =? "Galculator"     --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Steam"          --> doFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "Chromium"       --> doShift "2:web"
    , className =? "Google-chrome"  --> doShift "2:web"
    , className =? "Thunderbird"    --> doShift "3:mail"
    , className =? "Empathy"        --> doShift "4:im"
    , className =? "Skype"          --> doShift "4:im"
    , className =? "Xchat"          --> doShift "4:im"
    , className =? "VirtualBox"     --> doShift "5:vm"
    ]


-- Custom layouts
myLayoutHook = return ()
{-myLayout = onWorkspace "5:im" imLayout $ standartLayouts
  where
	standartLayouts = tall ||| wide ||| full ||| circle
	tall	= named "tall"		$ avoidStruts basic
	wide	= named "wide"		$ avoidStruts $ Mirror basic
	circle	= named "circle"	$ avoidStruts circleSimpleDefaultResizable
	full	= named "full"		$ noBorders Full
	imLayout = named "im" $ avoidStruts $	withIM (1%9) empathyRoster $ reflectHoriz $
						withIM (1%8) skypeRoster standartLayouts
	empathyRoster	= className "Empathy"	`And` Role "contact_list"
	skypeRoster		= className "Skype"		`And` Role "MainWindow"-}


myStartupHook = do
    spawn "stalonetray -i 12 --window-type normal --geometry=12x1+1800 --window-strut none --background black --icon-gravity NE"
    spawn "thunderbird"


-- Main
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaults {
        logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor xmobarTitleColor "". shorten 100
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
            , ppSep = "  "
            }
            , manageHook = manageDocks <+> myManageHook
    }


-- Defaults
defaults = defaultConfig {
    terminal            = myTerminal,
    focusFollowsMouse    = myFocusFollowsMouse,
    borderWidth         = myBorderWidth,
    modMask             = myModMask,
    workspaces          = myWorkspaces,
    normalBorderColor   = myNormalBorderColor,
    focusedBorderColor  = myFocusedBorderColor,

    keys                = myKeys,
    mouseBindings       = myMouseBindings,

    layoutHook          = smartBorders $ myLayoutHook,
    manageHook          = myManageHook,
    startupHook         = myStartupHook
}
