component extends="coldbox.system.Interceptor" {

	property name="layoutsToApply"             inject="coldbox:setting:googleTagManager.layouts" type="array";
	property name="systemConfigurationService" inject="delayedInjector:systemConfigurationService";

	public void function configure() {}

	public void function postLayoutRender( event, interceptData={} ) {
		var layout = Trim( interceptData.layout ?: "" );

		if ( Len( layout ) && layoutsToApply.findNoCase( layout ) ) {
			var gtmHeadSnippet = Trim( systemConfigurationService.getSetting( category="google-tag-manager", setting="tag_manager_head_snippet" ) );
			var gtmBodySnippet = Trim( systemConfigurationService.getSetting( category="google-tag-manager", setting="tag_manager_body_snippet" ) );

			if ( Len( gtmHeadSnippet ) && Len( gtmBodySnippet ) ) {
				var gtmRenderedHead = Trim( renderView( view="/general/_googleTagManagerHeadSnippet", args={ gtmHeadSnippet=gtmHeadSnippet, layout=layout, cache=true } ) );
				var gtmRenderedBody = Trim( renderView( view="/general/_googleTagManagerBodySnippet", args={ gtmBodySnippet=gtmBodySnippet, layout=layout, cache=true } ) );

				if ( Len( gtmRenderedHead ) ) {
					var renderedLayout = interceptData.renderedLayout ?: "";
					var headHtml       = reFindNoCase( "<head[^>]*>(.*?)</head>", renderedLayout, 1, true, "one" )[ "match" ][1] ?: "";

					// Add the DataLayer data if there is something to output in the request
					var gtmDataLayerData = getPublishedDataForAnalytics();

					if( StructCount( gtmDataLayerData ) ) {
						var gtmRenderedDataLayerData = Trim( renderView( view="/dataLayer/_googleTagManagerDataLayerData", args={ gtmDataLayerData=gtmDataLayerData, layout=layout, cache=false } ) );
						gtmRenderedHead = gtmRenderedDataLayerData & chr(10) & gtmRenderedHead;
					}

					if ( !isEmptyString( headHtml ) && reFindNoCase( "<title[^>]*>(.*?)</title>", headHtml ) ) {
						headHtml = reReplaceNoCase( headHtml, "</title>", "</title>#chr(10)##gtmRenderedHead#" );
						interceptData.renderedLayout = reReplaceNoCase( renderedLayout, "<head[^>]*>(.*?)</head>", headHtml );
					} else {
						interceptData.renderedLayout = reReplaceNoCase( renderedLayout, "<head(.*?)>", "<head\1>#chr(10)##gtmRenderedHead#" );
					}
				}
				if ( Len( gtmRenderedBody ) ) {
					interceptData.renderedLayout = reReplaceNoCase( interceptData.renderedLayout ?: "", "<body(.*?(<!--.+-->.*?)?)>", "<body\1>#chr(10)##gtmRenderedBody#" );
				}
			}
		}
	}

}
