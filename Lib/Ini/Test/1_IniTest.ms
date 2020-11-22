clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Ini.ms" )

Ini = Ini_v()

Ini.path (getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")

print ( "ini file = " + Ini.path #get )

Ini.save #section #key_1 #value

Ini.save "section" "key_2" "parameters as string"

print ( "key_2 = " + Ini.load #section #key_2 )