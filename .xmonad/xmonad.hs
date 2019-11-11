import XMonad
import XMonad.Actions.SwapWorkspaces
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.ThreeColumns (ThreeCol(ThreeColMid))
import XMonad.Util.EZConfig(additionalKeys)
import qualified Graphics.X11.ExtraTypes.XF86 as XF86

main = xmonad . ewmh =<< xmobar myConfig

myConfig = defaultConfig
  { terminal = "xterm-tm"
  , modMask  = mod4Mask
  , manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook defaultConfig
  , layoutHook = avoidStruts $ smartBorders layout
  , startupHook = startup
  } `additionalKeys` keyboardShortcuts

layout = tiled ||| three ||| Full where
  tiled   = Tall 1 (3/100) (1/2)
  three   = ThreeColMid 1 (3/100) (1/2)

keyboardShortcuts = [ ((controlMask .|. mod1Mask, xK_l), spawn "xscreensaver-command -l") -- lock screen
                    , ((controlMask .|. mod1Mask, xK_s), spawn "susp.sh")
                    , ((mod4Mask, xK_F8), spawn "pavucontrol") -- launch volume control
                    , ((mod4Mask, xK_g), spawn "google-chrome-beta")
                    , ((mod4Mask .|. shiftMask, xK_g), spawn "google-chrome-beta --incognito")
                    , ((mod4Mask, xK_v), spawn "gvim")
                    , ((mod4Mask, xK_m), spawn "gnome-system-monitor")
                    , ((mod4Mask, xK_c), spawn "gnome-calculator")
                    , ((mod4Mask .|. mod1Mask, xK_c), spawn "calendar")
                    , ((mod4Mask, xK_n), spawn "pcmanfm")
                    , ((mod4Mask, xK_x), spawn "xterm")
                    , ((mod4Mask, xK_r), spawn "gvim ~/vimwiki/Reciprocity.wiki")
                    , ((mod4Mask .|. mod1Mask, xK_s), runStartupScript)
                    , ((noModMask, XF86.xF86XK_AudioRaiseVolume), spawn "amixer set Master 10%+") -- increase volume
                    , ((noModMask, XF86.xF86XK_AudioLowerVolume), spawn "amixer set Master 10%-") -- decrease volume
                    , ((noModMask, XF86.xF86XK_MonBrightnessUp), spawn "xbacklight +10") -- increase brightness
                    , ((noModMask, XF86.xF86XK_MonBrightnessDown), spawn "xbacklight -10") -- decrease brightness
                    , ((mod4Mask .|. controlMask, xK_F9), spawn  "xrandr --output eDP1 --off --output DP1 --off") -- everything off
                    , ((mod4Mask .|. controlMask, xK_F10), spawn  "xrandr --output eDP1 --auto --output DP1 --off") -- only internal monitor
                    , ((mod4Mask .|. controlMask, xK_F11), spawn  "xrandr --output eDP1 --off --output DP1 --auto") -- only external
                    , ((mod4Mask .|. controlMask, xK_F12), spawn  "xrandr --output eDP1 --auto --output DP1 --auto --above eDP1") -- extend desktop
                    , ((controlMask, xK_F11), setKeyboardLayout "si")
                    , ((controlMask, xK_F12), setKeyboardLayout "us,si")
                    , ((noModMask, xK_Print ), spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1")
                    , ((controlMask, xK_Print ), spawn "scrot window_%Y-%m-%d-%H-%M-%S.png -d 1-u")
                    , ((mod4Mask .|. controlMask, xK_x), sendMessage $ Toggle REFLECTX)
                    , ((mod4Mask, xK_F1), spawn "redshift -O 6400")
                    , ((mod4Mask, xK_F2), spawn "redshift -O 4600")
                    , ((mod4Mask, xK_W), spawn "~/.xmonad/random_imgur_wallpaper.sh")
                    , ((mod4Mask .|. controlMask, xK_w), spawn "~/.xmonad/primary_wallpaper.sh")
                    , ((mod4Mask .|. mod1Mask, xK_w), spawn "~/.xmonad/save_wallpaper.sh")
                    ] ++ workspaceSwappingKeys ++ gap_keys

workspaceSwappingKeys = [((mod4Mask .|. controlMask, k), windows $ swapWithCurrent i)
                        | (i, k) <- zip (workspaces myConfig) [xK_1 ..]]

-- TODO figure out why this isn't working by default
gap_keys =
  [ ((mod4Mask .|. controlMask, xK_t), sendMessage $ ToggleGap U) -- toggle the top gap
  , ((mod4Mask .|. controlMask, xK_w), sendMessage $ IncGap 5 U)  -- increment the right-hand gap
  , ((mod4Mask .|. controlMask, xK_q), sendMessage $ DecGap 5 U)  -- decrement the right-hand gap
  ]

startup = do
  ewmhDesktopsStartup >> setWMName "LG3D"
  runStartupScript

runStartupScript = spawn "~/.xmonad/startup.sh"

setKeyboardLayout layout = spawn $ "setxkbmap " ++ layout
