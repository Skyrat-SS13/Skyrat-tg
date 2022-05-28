#define DEFAULT_TITLE_MAP_LOADTIME 150 SECONDS

#define DEFAULT_TITLE_SCREEN_IMAGE 'modular_skyrat/modules/title_screen/icons/skyrat_title_screen.png'
#define DEFAULT_TITLE_LOADING_SCREEN 'modular_skyrat/modules/title_screen/icons/loading_screen.gif'

#define TITLE_PROGRESS_CACHE_FILE "data/progress_cache.json"

#define DEFAULT_TITLE_HTML {"
	<html>
		<head>
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<style type='text/css'>
				@font-face {
					font-family: "Fixedsys";
					src: url("FixedsysExcelsior3.01Regular.ttf");
				}
				body,
				html {
					margin: 0;
					overflow: hidden;
					text-align: center;
					background-color: black;
					padding-top: 5vmin;
					-ms-user-select: none;
					cursor: default;
				}

				img {
					border-style:none;
				}

				.fone {
					position: absolute;
					width: auto;
					height: 100vmin;
					min-width: 100vmin;
					min-height: 100vmin;
					top: 50%;
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 0;
				}

				.container_nav {
					position: absolute;
					width: auto;
					min-width: 100vmin;
					min-height: 10vmin;
					padding-left: 0vmin;
					padding-top: 45vmin;
					box-sizing: border-box;
					top: 50%;
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 1;
				}

				.container_terminal {
					position: absolute;
					width: 100%;
					height: calc(100% - 7vmin);
					overflow: clip;
					box-sizing: border-box;
					padding: 3vmin 2vmin;
					top: 0%;
					left:0%;
					z-index: 1;
				}

				.container_progress {
					position: absolute;
					box-sizing: border-box;
					bottom: 3vmin;
					left: 2vmin;
					height: 4vmin;
					width: calc(100% - 4vmin);
					border-left: 2px solid green;
					border-right: 2px solid green;
					padding: 4px;
					background-color: black;
				}

				.progress_bar {
					width: 0%;
					height: 100%;
					background-color: green;
				}

				@keyframes fade_out {
					to {
						opacity: 0;
					}
				}

				.fade_out {
					animation: fade_out 2s both;
				}

				.container_notice {
					position: absolute;
					width: auto;
					box-sizing: border-box;
					padding-top: 1vmin;
					top: calc(50% - 10vmin);
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 1;
				}

				.menu_button {
					display: inline-block;
					font-family: "Fixedsys";
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color: #add8e6;
					margin-right: 100%;
					margin-top: 5px;
					padding-left: 6px;
					font-size: 4vmin;
					line-height: 4vmin;
					height: 4vmin;
					letter-spacing: 1px;
					border: 2px solid white;
					background-color: #0080ff;
					opacity: 0.5;
					cursor: pointer;
				}

				.menu_button:hover {
					border-left: 3px solid red;
					border-right: 3px solid red;
					font-weight: bolder;
					color: red;
					padding-left: 3px;
				}

				@keyframes pollsmove {
				50% {opacity: 0;}
				}

				.menu_poll {
					display: inline-block;
					font-family: "Fixedsys";
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color: #add8e6;
					margin-right: 100%;
					margin-top: 5px;
					padding-left: 6px;
					font-size: 4vmin;
					line-height: 4vmin;
					height: 4vmin;
					letter-spacing: 1px;
					border: 2px solid white;
					background-color: #0080ff;
					opacity: 0.5;
					animation: pollsmove 5s infinite;
				}

				.terminal_text {
					display: inline-block;
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: right;
					color:green;
					text-shadow: 1px 1px black;
					margin-right: 0%;
					margin-top: 0px;
					font-size: 2vmin;
					line-height: 1vmin;
					letter-spacing: 1px;
				}

				.menu_notice {
					display: inline-block;
					font-family: "Fixedsys";
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color: red;
					text-shadow: 1px 1px black;
					margin-right: 0%;
					margin-top: 0px;
					font-size: 3vmin;
					line-height: 2vmin;
				}

			</style>
		</head>
		<body>
			"}
