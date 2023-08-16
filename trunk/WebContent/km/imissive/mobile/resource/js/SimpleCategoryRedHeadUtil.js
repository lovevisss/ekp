/**
 * 简单分类工具类
 */
define([
  "km/imissive/mobile/resource/js/FilterItemRedHead",
  "mui/simplecategory/SimpleCategoryMixin"
], function(FilterItem,SimpleCategoryMixin) {
  return {

    // props:{createUrl:"",modelName:"",showFavoriteCate:true...}
    getAttId: function(props) {
      var claz = FilterItem.createSubclass([SimpleCategoryMixin]);
      new claz(props)._selectCate();
    }
  }
})
