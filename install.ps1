
Remove-Item -Path "$($env:USERPROFILE)\.vim" -Force -Confirm:$false
Remove-Item -Path "$($env:USERPROFILE)\AppData\Roaming\nushell" -Force -Confirm:$false

New-Item -ItemType HardLink -Force "$($env:USERPROFILE)\_vimrc" -Target "$($PSScriptRoot)\.vimrc"
New-Item -ItemType HardLink -Force "$($env:USERPROFILE)\.vimrc" -Target "$($PSScriptRoot)\.vimrc"
New-Item -ItemType HardLink -Force "$($env:USERPROFILE)\.gitconfig" -Target "$($PSScriptRoot)\.gitconfig"
New-Item -ItemType HardLink -Force "$($env:USERPROFILE)\AppData\Roaming\alacritty\alacritty.toml" -Target "$($PSScriptRoot)\.alacritty.toml"

New-Item -ItemType Junction -Force "$($env:USERPROFILE)\.vim" -Target "$($PSScriptRoot)\.vim"
New-Item -ItemType Junction -Force "$($env:USERPROFILE)\AppData\Local\nvim" -Target "$($PSScriptRoot)\.config\nvim"
New-Item -ItemType Junction -Force "$($env:USERPROFILE)\AppData\Roaming\nushell" -Target "$($PSScriptRoot)\.config\nushell"
