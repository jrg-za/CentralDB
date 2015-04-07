$query = "select * from DATABASE_MIRRORING_STATE_CHANGE where state = 6 or state = 7  or state = 8 or state =9"
 
Register-WMIEvent -Namespace 'root\Microsoft\SqlServer\ServerEvents\MSSQLSERVER'  -Query $query  
