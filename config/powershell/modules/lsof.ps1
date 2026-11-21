function lsof {
    <#
    .SYNOPSIS
        模拟 Unix lsof 命令（Windows 完美增强版）
    .DESCRIPTION
        支持查找端口占用、PID 关联连接，完美支持 IPv4/IPv6。
    #>
    [CmdletBinding(DefaultParameterSetName='Default')]
    param(
        [Parameter(ParameterSetName='Net', Position=0)]
        [string]$i,

        [Parameter(ParameterSetName='Pid')]
        [int]$p,

        [switch]$t
    )

    # 1. 获取所有网络连接数据
    $allConns = @()
    $allConns += Get-NetTCPConnection -ErrorAction SilentlyContinue
    $allConns += Get-NetUDPEndpoint -ErrorAction SilentlyContinue 2>$null

    # 2. 预解析过滤器（处理如 :5173 或 8080）
    $targetPort = $null
    if ($i -match ':(\d+)$') {
        $targetPort = [int]$matches[1]
    } elseif ($i -match '^\d+$') {
        $targetPort = [int]$i
    }

    # 3. 执行过滤逻辑
    $filtered = $allConns | Where-Object {
        $match = $true
        
        # 场景 A: 指定了 PID (-p)
        if ($PSCmdlet.ParameterSetName -eq 'Pid') {
            $match = $match -and ($_.OwningProcess -eq $p)
        }
        
        # 场景 B: 指定了网络过滤 (-i)
        if ($targetPort) {
            $match = $match -and ($_.LocalPort -eq $targetPort -or $_.RemotePort -eq $targetPort)
        } elseif ($i -and $i -notmatch '^:') {
            $match = $match -and (
                $_.LocalAddress -like "*$i*" -or 
                $_.RemoteAddress -like "*$i*" -or 
                $_.Protocol -like "*$i*"
            )
        }
        $match
    }

    # 4. 格式化输出对象
    $results = foreach ($conn in $filtered) {
        $proc = Get-Process -Id $conn.OwningProcess -ErrorAction SilentlyContinue
        
        # 地址美化：将 0.0.0.0 或 :: 转换为 *
        $localAddr = if ($conn.LocalAddress -eq '::' -or $conn.LocalAddress -eq '0.0.0.0') { "*" } else { $conn.LocalAddress }
        
        # 协议精准判断
        $protoName = if ($null -ne $conn.State) { "TCP" } else { "UDP" }

        [PSCustomObject]@{
            COMMAND = if ($proc) { $proc.ProcessName } else { "unknown" }
            PID     = $conn.OwningProcess
            USER    = if ($proc) { try { $proc.UserName } catch { "N/A" } } else { "N/A" }
            PROTO   = $protoName
            TYPE    = if ($conn.LocalAddress -match ':') { "IPv6" } else { "IPv4" }
            LOCAL   = "${localAddr}:$($conn.LocalPort)"
            REMOTE  = "$($conn.RemoteAddress):$($conn.RemotePort)"
            STATE   = if ($conn.State) { $conn.State } else { "Bound" }
        }
    }

    # 5. 输出处理
    if ($t) {
        return $results | Select-Object -ExpandProperty PID -Unique
    }

    if (-not $results) {
        if ($i) { Write-Host "No process found for input: $i" -ForegroundColor Yellow }
        return
    }

    $results | Sort-Object PID | Format-Table -AutoSize
}