


filein ( getFilenamePath(getSourceFileName()) + "/../MacroFile.ms" );
filein ( getFilenamePath(getSourceFileName()) + "/../Macro/Macro.ms" );



macro_file =getFilenamePath(getSourceFileName()) + "MacroFileTest.mcr";

MacroFile = MacroFile_Content_v()
MacroFile.load macro_file

print ( "Macros in file is 2 =	" + (MacroFile.macros.count==2 )as string )
print ( "MacroFile.file=	" + (MacroFile.file==macro_file) as string )

print MacroFile.file
print macro_file
