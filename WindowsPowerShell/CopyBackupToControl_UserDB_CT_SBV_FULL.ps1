Function Copy-ItemUNC($SourcePath, $TargetPath, $FileName)
{
	New-PSDrive -Name source -PSProvider FileSystem -Root $SourcePath | Out-Null
	New-PSDrive -Name target -PSProvider FileSystem -Root $TargetPath | Out-Null
    Try
    {
	    Copy-item -Path source:$FileName -Destination target:
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message 
    }
    Finally
    {
	    Remove-PSDrive source
	    Remove-PSDrive target
    }
}

$d = Get-Date
Try
{
    $Error.Clear()
	
	# Get backups less than 12 hours old from CashTrace_SBV FULL 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\CashTrace_SBV\FULL |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\CashTrace_SBV\FULL -FileName $_.Name}
# Remove backups more than 8 days old from CashTrace_SBV FULL  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\CashTrace_SBV\FULL' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	}
Catch
{
    $ErrorMessage = $_.ExceptionMessage
}

	