	WITH DependentViews (Child,Parent,Depth, ChildViewName, ParentViewNamw)
	AS
	(
		SELECT Child = SO.object_id, d.referenced_major_id, Depth = 1, SO.name, SOD.name
		FROM sys.objects SO
			LEFT OUTER JOIN sys.sql_dependencies d
				ON d.referenced_major_id = SO.object_id
				AND d.object_id <> SO.object_id
			LEFT OUTER JOIN sys.objects SOD 
				ON SOD.object_id = d.referenced_major_id
				AND SOD.type = 'V'
		WHERE SO.type = 'V'
		  AND d.referenced_major_id IS NULL
		  AND SOD.object_id IS NULL
		UNION ALL
		SELECT d.object_id, d.referenced_major_id, Depth = deps.Depth + 1, SO.name, SOD.name
		FROM sys.sql_dependencies d
			INNER JOIN sys.objects SO
				ON SO.object_id = d.object_id
				AND SO.type = 'V'
			INNER JOIN sys.objects SOD
				ON SOD.object_id = d.referenced_major_id
				AND SOD.type = 'V'
			INNER JOIN DependentViews deps 
				ON  deps.parent = d.object_id
	)
SELECT DISTINCT *
FROM DependentViews
--

