module LogEntry where


import Data.Time.Clock (UTCTime)
import Data.Time.Format (formatTime, defaultTimeLocale)

timeToString :: UTCTime -> String
timeToString = formatTime defaultTimeLocale "%a %d %T"

data LogLevel = Error | Warning | Info

data LogEntry = LogEntry { timestamp :: UTCTime, logLevel :: LogLevel, message :: String }

logLevelToString :: LogLevel -> String
logLevelToString Error   = "Error"
logLevelToString Warning = "Warning"
logLevelToString Info    = "Info"

logEntryToString :: LogEntry -> String
-- logEntryToString entry =
--   "<" ++ (timeToString $ timestamp entry) ++ ">: <" ++ (logLevelToString $ logLevel entry) ++ ">: <" ++ message entry ++ ">"
logEntryToString entry =
  (timeToString $ timestamp entry) ++ ": " ++ (logLevelToString $ logLevel entry) ++ ": " ++ message entry

test1 =
  let
    ct = read "2019-02-24 18:28:52.607875 UTC"::UTCTime
    le = LogEntry ct Info "Info Message"
  in
    logEntryToString le
