local message = require('keyboard.status-message')

function ssidChangedCallback() -- 回调
    ssid = hs.wifi.currentNetwork() -- 获取当前 WiFi ssid
    if (ssid ~= nil) then
        if (ssid == 'ADHO') then
            uid = "198750C0-0622-414E-9AC7-FC0AE2CE28A2" -- 公司的位置 uid，后面会讲
            hs.notify.new({title="网络位置", informativeText="位置切换到公司"}):send() -- 发出通知
        else
            uid = "76334284-22C0-4650-A944-2848204D1DA0"
            hs.notify.new({title="网络位置", informativeText="位置切换到家里"}):send()
        end
        os.execute("scselect " ..uid .." > /dev/null") -- 切换网络位置
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start() -- 开始监控
