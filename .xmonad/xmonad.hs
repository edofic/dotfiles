import System.Taffybar.Hooks.PagerHints (pagerHints)
import XMonad
import XMonad.Actions.SwapWorkspaces
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Util.EZConfig(additionalKeys)
import qualified Graphics.X11.ExtraTypes.XF86 as XF86

main = xmonad $ ewmh $ pagerHints $ myConfig

myConfig = defaultConfig
  { terminal = "xterm-tm"
  , modMask  = mod4Mask
  , manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook defaultConfig
  , layoutHook = avoidStruts $ smartBorders layout
  , startupHook = startup
  } `additionalKeys` keyboardShortcuts

layout = mkToggle (single REFLECTX) $
         mkToggle (single REFLECTY) $
           tiled ||| Full where -- ||| Mirror tiled
  tiled   = Tall nmaster delta ratio
  nmaster = 1
  ratio   = 1/2
  delta   = 3/100

keyboardShortcuts = [ ((controlMask .|. mod1Mask, xK_l), spawn "xscreensaver-command -l") -- lock screen
                    , ((controlMask .|. mod1Mask, xK_s), spawn "susp.sh")
                    , ((mod4Mask, xK_F8), spawn "pavucontrol") -- launch volume control
                    , ((mod4Mask, xK_g), spawn "google-chrome-stable")
                    , ((mod4Mask .|. shiftMask, xK_g), spawn "google-chrome-stable --incognito")
                    , ((mod4Mask, xK_v), spawn "gvim")
                    , ((mod4Mask, xK_m), spawn "gnome-system-monitor")
                    , ((mod4Mask, xK_c), spawn "gnome-calculator")
                    , ((mod4Mask .|. mod1Mask, xK_c), spawn "calendar")
                    , ((mod4Mask, xK_n), spawn "pcmanfm")
                    , ((mod4Mask, xK_x), spawn "xterm")
                    , ((mod4Mask, xK_r), spawn "gvim ~/delo/reciprocity/the_list")
                    , ((mod4Mask .|. mod1Mask, xK_s), runStartupScript)
                    , ((noModMask, XF86.xF86XK_AudioRaiseVolume), spawn "amixer set Master 10%+") -- increase volume
                    , ((noModMask, XF86.xF86XK_AudioLowerVolume), spawn "amixer set Master 10%-") -- decrease volume
                    , ((mod4Mask .|. controlMask, xK_F8), spawn  "xrandr --output eDP1 --mode 1024x768 --output HDMI2 --mode 1024x768 --same-as eDP1 ") -- mirror at 1024x768
                    , ((mod4Mask .|. controlMask, xK_F9), spawn  "xrandr --output eDP1 --off --output HDMI2 --off") -- everything off
                    , ((mod4Mask .|. controlMask, xK_F10), spawn  "xrandr --output eDP1 --auto --output DP1 --off --output HDMI2 --off") -- only internal monitor
                    , ((mod4Mask .|. controlMask, xK_F11), spawn  "xrandr --output eDP1 --off --output HDMI2 --auto") -- only hdmi
                    , ((mod4Mask .|.  mod1Mask, xK_F11), spawn  "xrandr --output eDP1 --off --output DP1 --auto") -- only hdmi
                    , ((mod4Mask .|. controlMask, xK_F12), spawn  "xrandr --output eDP1 --auto --primary --preferred --output HDMI2 --auto --right-of eDP1") -- extend desktop
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
                    ] ++ workspaceSwappingKeys

workspaceSwappingKeys = [((mod4Mask .|. controlMask, k), windows $ swapWithCurrent i)
                        | (i, k) <- zip (workspaces myConfig) [xK_1 ..]]

startup = do
  ewmhDesktopsStartup >> setWMName "LG3D"
  runStartupScript

runStartupScript = spawn "~/.xmonad/startup.sh"

setKeyboardLayout layout = spawn $ "setxkbmap " ++ layout
