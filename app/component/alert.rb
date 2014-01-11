module Component
	css = -> {
		position :absolute
		top 50.%
		left 0
		margin top: -115.px

		width 100.%

		text align: :center
		font size: 23.px
		padding 0
		border :none
		background :none
	}

	Warning = Lissio::Component::Alert::Warning.customize(&css)
	Error   = Lissio::Component::Alert::Danger.customize(&css)
end
