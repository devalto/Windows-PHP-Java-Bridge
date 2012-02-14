; irisbridge.nsi

;--------------------------------

!include "LogicLib.nsh"

!undef LOGICLIB_VERBOSITY
!define LOGICLIB_VERBOSITY 4   ; For debugging - watch what logiclib does with your code!
!define TheName "PHP/Java Bridge + JasperReports"

; The name of the installer
Name "${TheName}"

; The file to write
OutFile "pjb-windows.exe"

; The default installation directory
InstallDir $PROGRAMFILES\PHP-Java-Bridge

; Request application privileges for Windows Vista
RequestExecutionLevel admin

; Loads the french language for the installer
LoadLanguageFile "${NSISDIR}\Contrib\Language files\French.nlf"

ShowInstDetails show

;--------------------------------

; Pages

Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

Section "Installation des fichiers"

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  File install-service.cmd

  ; Set output path to the bin directory
  SetOutPath $INSTDIR\bin
  
  ; Binaries from Apache Commons Daemon
  File bin\PhpJavaBridge.exe
  File bin\PhpJavaBridgew.exe

  ; Set output path to the lib directory.
  SetOutPath $INSTDIR\lib
  
  ; ADA lib
  File lib\alticJasper.jar
  File lib\com.adaconsult.dsrb.jar
  
  ; PHP/Java Bridge lib
  File lib\JavaBridge.jar
  
  ; MySQL lib
  File lib\mysql-connector-java-5.1.18-bin.jar
  
  ; Lib from JasperReports
  File lib\ant-1.7.1.jar
  File lib\antlr-2.7.5.jar
  File lib\barbecue-1.5-beta1.jar
  File lib\barcode4j-2.0.jar
  File lib\batik-anim.jar
  File lib\batik-awt-util.jar
  File lib\batik-bridge.jar
  File lib\batik-css.jar
  File lib\batik-dom.jar
  File lib\batik-ext.jar
  File lib\batik-gvt.jar
  File lib\batik-parser.jar
  File lib\batik-script.jar
  File lib\batik-svg-dom.jar
  File lib\batik-svggen.jar
  File lib\batik-util.jar
  File lib\batik-xml.jar
  File lib\bcel-5.2.jar
  File lib\bsh-2.0b4.jar
  File lib\castor-1.2.jar
  File lib\commons-beanutils-1.8.0.jar
  File lib\commons-collections-2.1.1.jar
  File lib\commons-digester-1.7.jar
  File lib\commons-javaflow-20060411.jar
  File lib\commons-logging-1.0.4.jar
  File lib\dom4j-1.6.1.jar
  File lib\groovy-all-1.7.5.jar
  File lib\hibernate3.jar
  File lib\hsqldb-1.8.0-10.jar
  File lib\iText-2.1.7.jar
  File lib\jackson-core-lgpl-1.7.4.jar
  File lib\jackson-mapper-lgpl-1.7.4.jar
  File lib\jaxen-1.1.1.jar
  File lib\jcommon-1.0.15.jar
  File lib\jdt-compiler-3.1.1.jar
  File lib\jfreechart-1.0.12.jar
  File lib\jpa.jar
  File lib\jxl-2.6.10.jar
  File lib\log4j-1.2.15.jar
  File lib\mondrian-3.1.1.12687.jar
  File lib\png-encoder-1.5.jar
  File lib\poi-3.7-20101029.jar
  File lib\poi-ooxml-3.7-20101029.jar
  File lib\poi-ooxml-schemas-3.7-20101029.jar
  File lib\rhino-1.7R1.jar
  File lib\saaj-api-1.3.jar
  File lib\serializer.jar
  File lib\servlet.jar
  File lib\spring-beans-2.5.5.jar
  File lib\spring-core-2.5.5.jar
  File lib\velocity-1.7-dep.jar
  File lib\xalan-2.7.1.jar
  File lib\xbean.jar
  File lib\xercesImpl-2.7.0.jar
  File lib\xml-apis-ext.jar
  File lib\xml-apis.jar

  SetOutPath $INSTDIR\php
  
  ; Put file there
  File php\JavaBridge.php
  
  WriteUninstaller $INSTDIR\uninstall.exe
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhpJavaBridge" \
                 "DisplayName" "${TheName}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhpJavaBridge" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhpJavaBridge" \
                 "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
  
  ; Install as a service
  ExecWait '"$INSTDIR\install-service.cmd" "$INSTDIR"'
  
SectionEnd ; end the section

# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "Uninstall"
 
  # Always delete uninstall first
  Delete $INSTDIR\uninstall.exe
  
  # Remove service
  ExecWait '"$INSTDIR\bin\PhpJavaBridge.exe" "//DS"'
 
  # now delete installed file
  RMDir /r $INSTDIR
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhpJavaBridge"
 
SectionEnd