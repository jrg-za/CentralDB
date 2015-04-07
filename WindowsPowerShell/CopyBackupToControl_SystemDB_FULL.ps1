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
    # Distribution
    # Get backups less than 12 hours old from distribution FULL 
    Get-ChildItem I:\Backups\ASPRODDB-BUR01\distribution\FULL |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
        ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\distribution\FULL -FileName $_.Name}
    # Remove backups more than 8 days old from distribution FULL  
    Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\distribution\FULL' -ErrorAction SilentlyContinue |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
        ForEach-Object { Remove-Item $_.FullName}

    # Master
    # Get backups less than 12 hours old from master FULL 
    Get-ChildItem I:\Backups\ASPRODDB-BUR01\master\FULL |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
        ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\master\FULL -FileName $_.Name}
    # Remove backups more than 8 days old from master FULL  
    Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\master\FULL' -ErrorAction SilentlyContinue |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
        ForEach-Object { Remove-Item $_.FullName}

    # Model
    # Get backups less than 12 hours old from model FULL 
    Get-ChildItem I:\Backups\ASPRODDB-BUR01\model\FULL |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
        ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\model\FULL -FileName $_.Name}
    # Remove backups more than 8 days old from model FULL  
    Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\model\FULL' -ErrorAction SilentlyContinue |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
        ForEach-Object { Remove-Item $_.FullName}

    # msdb
    # Get backups less than 12 hours old from msdb FULL 
    Get-ChildItem I:\Backups\ASPRODDB-BUR01\msdb\FULL |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
        ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\msdb\FULL -FileName $_.Name}
    # Remove backups more than 8 days old from msdb FULL  
    Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\msdb\FULL' -ErrorAction SilentlyContinue |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
        ForEach-Object { Remove-Item $_.FullName}
}
Catch
{
    $ErrorMessage = $_.ExceptionMessage
}

	


