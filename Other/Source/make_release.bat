@echo off
:: Initialise the environment
	:: These values are as they are for Chris Morgan.
	cd ..\..
	set PAL=%cd%
	cd \
	set ROOT=%cd%
	set PYTHONPATH=F:\PortableApps\pymodules\Sphinx-0.6.5;F:\PortableApps\pymodules\docutils;F:\PortableApps\pymodules\docutils\extras;F:\PortableApps\pymodules\Jinja2-2.3.1;F:\PortableApps\pymodules\Pygments-1.3.1
	set SPHINXBUILD=F:\PortableApps\Python25\python.exe F:\PortableApps\pymodules\Sphinx-0.6.5\sphinx-build.py
	set makensis=%ROOT%PortableApps\UnicodeNSISPortable\App\NSIS\makensis.exe
	set PAI=%ROOT%PortableApps\PortableApps.comInstallerU\PortableApps.comInstallerU.exe
	set ALLSPHINXOPTS=-d _build/doctrees %SPHINXOPTS% .

echo Building the PortableApps.com Launcher Manual...
	cd "%PAL%\Other\Source\Manual"
	:: clean
		if exist _build rmdir /q /s _build
		if exist "%PAL%\App\Manual" rmdir /q /s "%PAL\App\Manual"
	:: html
		%SPHINXBUILD% -b html %ALLSPHINXOPTS% ../../../App/Manual
	:: partial clean
		rmdir /q /s "%PAL%\App\Manual\_sources"
		del /q "%PAL%\App\Manual\.buildinfo"
		del /q "%PAL%\App\Manual\objects.inv"
		rmdir /q /s _build
		del /q _ext\paldocs.pyc

echo Building the PortableApps.com Launcher Generator...
	"%makensis%" "%PAL%\Other\Source\GeneratorWizard.nsi"

echo Building the PortableApps.com Launcher...
	"%PAL%\PortableApps.comLauncherGenerator.exe" "%PAL%"

echo Building the PortableApps.com Launcher installer...
	"%PAI%" "%PAL%"

:: go back where we started
	cd %PAL%\Other\Source
	echo Done!