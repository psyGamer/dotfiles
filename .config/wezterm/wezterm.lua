local wt=require("wezterm")

return {
	 -- Font
	color_scheme="Dark+",
	font=wt.font("Jetbrains Mono"),
	harfbuzz_features={"calt=0", "clig=0", "liga=0"},
	 -- Keybinds	
	disable_default_key_bindings=true,
	keys={
		{key="c", mods="CTRL", action=wt.action{CopyTo="PrimarySelection"}},
		{key="v", mods="CTRL", action=wt.action{PasteFrom="PrimarySelection"}},

		{key="r", mods="CTRL|SHIFT", action="ReloadConfiguration"},

		{key="+", mods="CTRL", action="IncreaseFontSize"},
		{key="#", mods="CTRL", action="DecreaseFontSize"},

		{key="t", mods="CTRL", action=wt.action{SpawnTab="CurrentPaneDomain"}},
		{key="n", mods="CTRL", action="SpawnWindow"},

		{key="w", mods="CTRL", action=wt.action{CloseCurrentTab={ confirm=true }}},
		{key="g", mods="CTRL", action=wt.action{CloseCurrentTab={ confirm=true }}},
		{key="q", mods="CTRL", action="QuitApplication"},
		
		{key="f", mods="CTRL", action=wt.action{Search={CaseInSensitiveString=""}}},
		{key="f", mods="CTRL|SHIFT", action=wt.action{Search={CaseSensitiveString=""}}},

		{key="DownArrow", mods="CTRL|SHIFT", action=wt.action{SplitVertical={args={"zsh"}}}},
		{key="RightArrow", mods="CTRL|SHIFT", action=wt.action{SplitHorizontal={args={"zsh"}}}},

		{key="UpArrow", mods="ALT", action=wt.action{ActivatePaneDirection="Up"}},
		{key="DownArrow", mods="ALT", action=wt.action{ActivatePaneDirection="Down"}},
		{key="RightArrow", mods="ALT", action=wt.action{ActivatePaneDirection="Right"}},
		{key="LeftArrow", mods="ALT", action=wt.action{ActivatePaneDirection="Left"}},

		{key="UpArrow", mods="SHIFT|ALT", action=wt.action{AdjustPaneSize={"Up", 2}}},
		{key="DownArrow", mods="SHIFT|ALT", action=wt.action{AdjustPaneSize={"Down", 2}}},
		{key="RightArrow", mods="SHIFT|ALT", action=wt.action{AdjustPaneSize={"Right", 2}}},
		{key="LeftArrow", mods="SHIFT|ALT", action=wt.action{AdjustPaneSize={"Left", 2}}},
	},

	window_background_opacity = 0.85
}
