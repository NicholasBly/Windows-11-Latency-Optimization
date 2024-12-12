## Basic Update Settings
1. Open CMD as admin.
2. Type "winget upgrade".
3. Type "Y" if prompted.
4. Winget will show all the programs on your PC that have updates
5. Type "winget upgrade --all" to update everything
6. Type "winget upgrade <ID>" and replace ID with the ID of the program listed.
7. To upgrade all without selected programs, pin the program using the syntax "winget pin add --id <ID> --version <0.70.*>", replacing the values in <> with your ID and optionally a version number.

## Windows Update Settings
1. Run O&O Shutup 10++, check for changes made by Windows.
2. Press "show changes" to view settings that were changed since the last time you ran the software.

1. Run WPD, check for changes made by Windows.

1. Run Privacy.Sexy, select settings you have used in the past or run saved scripts you have saved previously to your PC if applicable.

## Graphics Driver Update Settings
Every time you upgrade your graphics driver you need to re-apply these settings:
1) Nvidia Control Panel – if you selected a 'clean' install you will need to redo the settings
   -To apply recommended settings, use Nvidia Profile Inspector and import the profile .nip file within this GitHub project.
   -Alternatively, use Nvidia Profile Inspector to save your profile before updating graphics drivers to have a one-click option after updating.
3) MSI Mode – Automatically enabled for you if you use NVCleanstall (and automatic if using a 30xx or 40xx graphics card)
4) Processor Affinities – Automatically enabled for you if you use NVCleanstall's processor affinities option
5) DisableDynamicPstate – Run the "Disable_P-States.bat" file as a one-click option for writing the registry value
6) IRQ Priority – Check the IRQ value in MSInfo for your graphics card.
   - "Computer\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" --> "IRQ4294967199Priority" == DWORD32 with value 1 ("4294967199" is mine, but yours will be different based on the value listed in MSInfo)
8) Reboot your machine, check if everything is selected properly -> Melody's Interrupt Checker, etc.
