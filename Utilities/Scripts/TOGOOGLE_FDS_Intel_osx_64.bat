@echo off

Rem Windows batch file to upload FDS release to the google download site.

set envfile=%userprofile%\fds_smv_env.bat
IF EXIST %envfile% GOTO endif_envexist
echo ***Fatal error.  The environment setup file %envfile% does not exist. 
echo Create a file named %envfile% and use SMV/scripts/fds_smv_env_template.bat
echo as an example.
echo.
echo Aborting now...
pause>NUL
goto:eof

:endif_envexist

call %envfile%

%svn_drive%
cd %svn_root%\Utilities\to_google

set glabels=Type-Installer,Opsys-OSX,%fds_google_level%
set dplatform=64 bit OSX
set platform=osx64
set summary=FDS %fds_version% for %dplatform% (SVN r%fds_revision%)
set exe=fds_%fds_version%_%fds_revision%_%platform%.zip

echo Uploading %exe%
echo FDS %fds_google_level% version=%fds_version% revision=%fds_revision%
echo.
echo press any key to proceed with upload, CTRL c to abort
pause>NUL

  if not exist %exe% goto abort_upload
  echo.
  echo Uploading %summary% - %exe%
  echo googlecode_upload.py --passwd-file-dir %google_password_dir% --config-dir none -s "%summary%" -p fds-smv -u %google_username% -l %glabels% %exe%
       %upload% --passwd-file-dir %google_password_dir% --config-dir none -s "%summary%" -p fds-smv -u %google_username% -l %glabels% %exe%

echo.
echo Uploads complete
pause
goto:eof

:abort_upload
echo %exe% does not exist - upload to google failed
pause
