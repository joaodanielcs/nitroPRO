$ProgressPreference = 'SilentlyContinue';
$pasta = "$env:TEMP\NitroInstall";
New-Item -ItemType Directory -Path $pasta -Force | Out-Null;
$parte1 = "$pasta\nitro_pro11_x64.z01";
$parte2 = "$pasta\nitro_pro11_x64.z02";
$arquivoZip = "$pasta\nitro_pro11_x64.zip";
curl.exe -sS -L "https://drive.google.com/uc?export=download&id=1T075cvLtIqr4UNKRovMwtLofZyyL4F3E" -o $parte1;
curl.exe -sS -L "https://drive.google.com/uc?export=download&id=1BgXaHxwxQuzOao_O0U8cSGuvjPCtOpTw" -o $parte2;
Rename-Item -Path $parte2 -NewName "nitro_pro11_x64.zip" -Force;
$winrar = "${env:ProgramFiles(x86)}\WinRAR\WinRAR.exe";
if (!(Test-Path $winrar)) {
    $winrar = "${env:ProgramFiles}\WinRAR\WinRAR.exe";
} else {
  irm https://raw.githubusercontent.com/joaodanielcs/winrar/refs/heads/main/winrar.ps1 | iex;
  $winrar = "${env:ProgramFiles}\WinRAR\WinRAR.exe";
};
& $winrar x -ibck "$arquivoZip" "$pasta\" | Out-Null;
$msi = Get-ChildItem -Path $pasta -Filter *.msi -Recurse | Select-Object -First 1;
if ($msi) {
    Start-Process msiexec -ArgumentList "/i `"$($msi.FullName)`" /qn" -Wait;
    Remove-Item $msi.FullName -Force -ErrorAction SilentlyContinue;
};
Remove-Item $pasta -Recurse -Force -ErrorAction SilentlyContinue;
Remove-Item "$env:TEMP\NitroPDF" -Recurse -Force -ErrorAction SilentlyContinue;

$ProgressPreference = 'Continue';
Remove-Item "C:\Users\Public\Desktop\Nitro Pro.lnk" -Force -ErrorAction SilentlyContinue;
