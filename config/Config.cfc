component {

	public void function configure( required struct config ) {
		var conf         = arguments.config;
		var settings     = conf.settings     ?: {};
		var interceptors = conf.interceptors ?: [];

		settings.googleTagManager         = settings.googleTagManager         ?: {};
		settings.googleTagManager.layouts = settings.googleTagManager.layouts ?: [ "main" ];

		interceptors.append( { class="app.extensions.preside-ext-google-tag-manager.interceptors.GoogleTagManagerLayoutInterceptor", properties={} } );
	}

}