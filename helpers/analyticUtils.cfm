<cfscript>
	public void function publishDataForAnalytics( required struct data ) {
		var prc = getRequestContext().getCollection( private = true );

		prc._analyticsData = prc._analyticsData ?: {};

		StructAppend( prc._analyticsData, arguments.data );
	}

	public struct function getPublishedDataForAnalytics() {
		var prc = getRequestContext().getCollection( private = true );

		return prc._analyticsData ?: {};
	}
</cfscript>