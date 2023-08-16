define("km/imissive/mobile/resource/js/MissiveNavBarMixin", [
  "dojo/dom-construct",
  "dojo/_base/declare",
  "dojo/dom-class",
  "dojo/topic",
  "dojo/_base/array",
  "mui/nav/_ShareNavBarMixin",
  "dojo/_base/lang",
], function (
  domConstruct,
  declare,
  domClass,
  topic,
  array,
  _ShareNavBarMixin,
  lang
) {
  var cls = declare("mui.nav.MissiveNavBarMixin", null, {
    buildRendering: function () {
      this.inherited(arguments);
      var _self = this;
      var changeNav = function (view) {
        var wgt = _self;
        for (var i = 0; i < wgt.getChildren().length; i++) {
          var tmpChild = wgt.getChildren()[i];
          if (view.id == tmpChild.moveTo) {
            tmpChild.beingSelected(tmpChild.domNode);
            return;
          }
        }
      };
      topic.subscribe("mui/form/validateFail", function (view) {
        changeNav(view);
      });
      topic.subscribe("mui/view/currentView", function (view) {
        changeNav(view);
      });
    }
  });
  return cls;
});
