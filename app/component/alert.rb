module Component
	colors = { background: :transparent, border: :transparent }
	css    = -> {
		position :absolute
		top 50.%
		left 0
		margin top: -115.px

		width 100.%

		text align: :center
		font size: 23.px
	}

	Warning = Lissio::Component::Alert::Warning.customize(colors, &css)
	Error   = Lissio::Component::Alert::Danger.customize(colors, &css)
end
