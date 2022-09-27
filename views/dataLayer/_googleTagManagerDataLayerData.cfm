<cfparam name="args.gtmDataLayerData" type="struct" />

<cfoutput>
	<script type="text/javascript">
		window.dataLayer = window.dataLayer || [];
		window.dataLayer.push( #serializeJSON( args.gtmDataLayerData )# );
	</script>
</cfoutput>