param(
	[string]$SQLInst="ASPRODDB-BUR01\MoDBA",
	[string]$Centraldb="CentralDB"
	)
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.ConnectionInfo') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SqlWmiManagement') | out-null

$cn = new-object system.data.SqlClient.SqlConnection(“server=$SQLInst;database=$CentralDB;Integrated Security=true;”);
$cn.Open()
# Fetch Server list into the Data source from Srv.ServerList Table from CentralDB
$ds = new-object "System.Data.DataSet" "dsServerList"
$q = " SELECT DISTINCT ServerName, InstanceName FROM [Svr].[ServerList] WHERE   SQLPing = 'True' AND (PingSnooze IS NULL OR PingSnooze <= GETDATE()) AND ((MaintStart IS NULL) or (MaintEnd IS NULL) or (GETDATE() NOT BETWEEN MaintStart AND MaintEnd ))"
$da = new-object "System.Data.SqlClient.SqlDataAdapter" ($q, $cn)
$da.Fill($ds)
$cn.Close()
$dtServerList = $ds.Tables[0]
$SvrList = $dtServerList | Select ServerName, InstanceName
$SvrList | foreach {
	$srv = $_	
	# Get ServerName and InstanceName from CentralDB
	$server = $srv.ServerName
	$instance = $srv.InstanceName
	# Ping the machine to see if it's on the network
	$results = gwmi -query "select StatusCode from Win32_PingStatus where Address = '$server'" 
	$responds = $false	
	foreach ($result in $results) {
		# If the machine responds break out of the result loop and indicate success
		if ($result.statuscode -eq 0) {
			$responds = $true
			break
		}
	}
	if ($responds) {
		# Check SQL Services are running or not
		$res = new-object Microsoft.SqlServer.Management.Common.ServerConnection($instance)
		$resp = $false
			if ($res.ProcessID -ne $null) {
			$resp = $true
    			}

    		If ($resp) {
		}else{
		Send-MailMessage -To "howard@modelwaresystems.com" -From "howard@modelwaresystems.com" -SmtpServer "mail.ModelwareSystems.com" -Subject "CentralDB: Unable to connect to $instance" -body "Unable to connect to $instance Instance. Please make sure if you are able to RDP to the box and Check SQL Services. "
		}
    	}  
 	else {
		Send-MailMessage -To "howard@modelwaresystems.com" -From "howard@modelwaresystems.com" -SmtpServer "mail.ModelwareSystems.com" -Subject "CentralDB: XXX Unable to ping $server" -body "Unable to ping $server Server. Please make sure if you are able to RDP to the box and Check SQL Services. "
	}
}