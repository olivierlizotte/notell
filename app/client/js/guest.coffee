class NT.Guest
	constructor: ->
		@init_socket()

		document.title += _.l(' - Guest')

		$(document).keyup (e) =>
			switch e.keyCode
				when 70, 32, 13
					@full_screen()

	init_socket: ->
		@socket = io.connect location.origin

		@socket.on 'state', (state) =>
			indices = state.indices
			Reveal.slide indices.h, indices.v, indices.f

			if state.is_paused and not Reveal.isPaused()
				Reveal.togglePause()

		@socket.on 'slidechanged', (indices) =>
			Reveal.slide indices.h, indices.v, indices.f

		@socket.on 'paused', =>
			if not Reveal.isPaused()
				Reveal.togglePause()

		@socket.on 'resumed', =>
			if Reveal.isPaused()
				Reveal.togglePause()

	full_screen: ->

		element = document.body

		requestMethod = element.requestFullScreen or
							element.webkitRequestFullscreen or
							element.webkitRequestFullScreen or
							element.mozRequestFullScreen or
							element.msRequestFullScreen

		if requestMethod
			requestMethod.apply element

