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
	
# G4S
# Get backups less than 12 hours old from CashTrace_G4S DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\CashTrace_G4S\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\CashTrace_G4S\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from CashTrace_G4S DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\CashTrace_G4S\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	# Get backups less than 12 hours old from CashVault_G4S DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\CashVault_G4S\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\CashVault_G4S\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from CashVault_G4S DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\CashVault_G4S\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	# Get backups less than 12 hours old from WorkflowStore_G4S DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\WorkflowStore_G4S\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\WorkflowStore_G4S\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from WorkflowStore_G4S DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\WorkflowStore_G4S\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	# Get backups less than 12 hours old from CashTrace_SBV DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\CashTrace_SBV\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\CashTrace_SBV\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from CashTrace_SBV DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\CashTrace_SBV\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	# Get backups less than 12 hours old from CashVault_SBV DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\CashVault_SBV\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\CashVault_SBV\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from CashVault_SBV DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\CashVault_SBV\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}

	# Get backups less than 12 hours old from WorkflowStore_SBV DIFF 
Get-ChildItem I:\Backups\ASPRODDB-BUR01\WorkflowStore_SBV\DIFF |
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
    ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\WorkflowStore_SBV\DIFF -FileName $_.Name}
# Remove backups more than 8 days old from WorkflowStore_SBV DIFF  
Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\WorkflowStore_SBV\DIFF' -ErrorAction SilentlyContinue | 
  Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
    ForEach-Object { Remove-Item $_.FullName}
	
# Distribution
    # Get backups less than 12 hours old from distribution DIFF 
    Get-ChildItem I:\Backups\ASPRODDB-BUR01\distribution\DIFF |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -gt ($d.AddHours(-12))} |
        ForEach-Object { Copy-ItemUNC -SourcePath $_.DirectoryName -TargetPath \\197.96.167.80\ASPRODDB-BUR01$\distribution\DIFF -FileName $_.Name}
    # Remove backups more than 8 days old from distribution DIFF  
    Get-ChildItem '\\197.96.167.80\ASPRODDB-BUR01$\distribution\DIFF' -ErrorAction SilentlyContinue |
      Where-Object { $_.PSIsContainer -eq $false -and $_.LastWriteTime -lt ($d.AddDays(-8))} |
        ForEach-Object { Remove-Item $_.FullName}

	}
Catch
{
    $ErrorMessage = $_.ExceptionMessage
}

	
