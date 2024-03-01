component extends="coldbox.system.Interceptor" {

	property name="layoutsToApply"             inject="coldbox:setting:googleTagManager.layouts" type="array";
	property name="systemConfigurationService" inject="delayedInjector:systemConfigurationService";

	public void function configure() {}

	public void function postRenderDelayedViewlets( event, interceptData={} ) {
		var layout = ListFirst( event.getCurrentLayout(), "." );

		if ( Len( layout ) && ArrayFindNoCase( layoutsToApply, layout ) ) {
			var gtmHeadSnippet = Trim( systemConfigurationService.getSetting( category="google-tag-manager", setting="tag_manager_head_snippet" ) );
			var gtmBodySnippet = Trim( systemConfigurationService.getSetting( category="google-tag-manager", setting="tag_manager_body_snippet" ) );

			if ( Len( gtmHeadSnippet ) && Len( gtmBodySnippet ) ) {
				var gtmRenderedHead = Trim( renderView( view="/general/_googleTagManagerHeadSnippet", args={ gtmHeadSnippet=gtmHeadSnippet, cache=true } ) );
				var gtmRenderedBody = Trim( renderView( view="/general/_googleTagManagerBodySnippet", args={ gtmBodySnippet=gtmBodySnippet, cache=true } ) );

				if ( Len( gtmRenderedHead ) ) {
					var renderedLayout = interceptData.renderedContent ?: "";
					var headHtml       = reFindNoCase( "<head[^>]*>(.*?)</head>", renderedLayout, 1, true, "one" )[ "match" ][1] ?: "";

					// Add the DataLayer data if there is something to output in the request
					var gtmDataLayerData = getPublishedDataForAnalytics();

					if( StructCount( gtmDataLayerData ) ) {
						var gtmRenderedDataLayerData = Trim( renderView( view="/dataLayer/_googleTagManagerDataLayerData", args={ gtmDataLayerData=gtmDataLayerData, cache=false } ) );
						gtmRenderedHead = gtmRenderedDataLayerData & chr(10) & gtmRenderedHead;
					}

					if ( !isEmptyString( headHtml ) && reFindNoCase( "<title[^>]*>(.*?)</title>", headHtml ) ) {
						headHtml = reReplaceNoCase( headHtml, "</title>", "</title>#chr(10)##gtmRenderedHead#" );
						interceptData.renderedContent = reReplaceNoCase( renderedLayout, "<head[^>]*>(.*?)</head>", headHtml );
					} else {
						interceptData.renderedContent = reReplaceNoCase( renderedLayout, "<head(.*?)>", "<head\1>#chr(10)##gtmRenderedHead#" );
					}
				}
				if ( Len( gtmRenderedBody ) ) {
					interceptData.renderedContent = reReplaceNoCase( interceptData.renderedContent ?: "", "<body(.*?(<!--.+-->.*?)?)>", "<body\1>#chr(10)##gtmRenderedBody#" );
				}
			} else {
				// Add the DataLayer data if there is something to output in the request but the GTM script is NOT installed via this extension
				var gtmDataLayerData = getPublishedDataForAnalytics();

				if( StructCount( gtmDataLayerData ) ) {
					var gtmRenderedDataLayerData = Trim( renderView( view="/dataLayer/_googleTagManagerDataLayerData", args={ gtmDataLayerData=gtmDataLayerData, cache=false } ) );
					interceptData.renderedContent = reReplaceNoCase( interceptData.renderedContent ?: "", "<head(.*?)>", "<head\1>#chr(10)##gtmRenderedDataLayerData#" );
				}
			}
		}
	}

}