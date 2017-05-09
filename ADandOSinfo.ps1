Get-ADComputer -Filter * -Property * | #This will query your entire domain

   Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,CanonicalName | #Selection of parameters, ConanicalName is a little friendlier than splitting the DistinguishedName

   Where-Object { ($_.OperatingSystem -EQ 'Windows 7 Enterprise') -and ($_.CanonicalName -like 'test.domain/Test/*') } | #The Where-Object clause is a delimiter based on your criteria. You can Add OU, remove OS, etc.

   Export-Csv 'C:\temp\ThisIsaFile.csv' #output to CSV

 

#To keep the script light, trim in Excel. Search and replace the CanonicalName tail (hostname) to eliminate
