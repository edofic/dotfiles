import System.Taffybar

import System.Taffybar.Battery
import System.Taffybar.CommandRunner
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Text.CPUMonitor
import System.Taffybar.Text.MemoryMonitor
import System.Taffybar.Weather
import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Widgets.PollingLabel
import System.Taffybar.WorkspaceSwitcher

import System.Information.Memory
import System.Information.CPU2

import qualified Graphics.UI.Gtk as Gtk
import qualified System.Process as P

memCallback = do
  mi <- parseMeminfo
  return $ "mem: " ++ (show $ round $ memoryUsedRatio mi * 100) ++ "%"

mkLabel interval producer = do
  l <- pollingLabelNew "" interval producer
  Gtk.widgetShowAll l
  return l

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
  let clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
      pager = taffyPagerNew defaultPagerConfig
      note = notifyAreaNew defaultNotificationConfig
      mem = mkLabel 1 memCallback
      tray = systrayNew
      batt = textBatteryNew "batt: $percentage$% ($time$)" 10
      cpu = textCpuMonitorNew "cpu: $total$" 1.0
      kernel = commandRunnerNew 3600 "uname" ["-srn"] "<uname error>" "#00ff00"

  defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note]
                                        , endWidgets = [ tray, clock, kernel, mem, cpu, batt ]
                                        , barHeight = 18
                                        }
