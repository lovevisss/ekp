define(["mui/util"], function(util) {
    function portletLoad(params, load) {
        var type = util.getUrlParameter(params, "type")

        var html =
            '<div data-dojo-type="kms/knowledge/mobile/mportal/index/js/AllCountItem" ' +
            "data-dojo-props=\"type:'!{type}'\">" +
            "</div>";
        html = util.urlResolver(html, {
            type: type
        })
        load({html: html, cssUrls: ["/kms/knowledge/mobile/mportal/index/style/allCountItem.css"]})
    }

    return {
        load: function(params, require, load) {
            portletLoad(params, load)
        }
    }
})