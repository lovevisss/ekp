define(function (require, exports, module) {
    var $ = require('lui/jquery');
    var modelingLang = require("lang!sys-modeling-base");
    var _MXCOLOR = {
        DEF: '#e8ecef',
        FILL: "#A0ABBD",
        FONT: "#FFFFFF",
        STROKE: "#D0D0D0",
        MAIN: "#34435B",
        EMPTY: '#e8ecef',
        EMPTY_FONT: '#90A5C8',
        WHITER: "#FFFFFF",
        BLACK: "#000000"
    };
    var _MXICON = {
        ADD: "add.png",
        DEL: "graph/delete.png",
        X: "graph/needmodified.png",
        NONE: ""
    };
    var _MXSTYLE = {
        //线条
        "normal_edge": {
            "STYLE_ROUNDED": true,
            "STYLE_STROKECOLOR": _MXCOLOR.FILL,
            "STYLE_STROKEWIDTH": 1,
            "STYLE_EDGE": mxEdgeStyle.ElbowConnector
        },
        // "self_edge": {
        //     "STYLE_STROKECOLOR": _MXCOLOR.MAIN
        // },
        //默认样式
        "_def": {
            "STYLE_FONTSIZE": 14,
            "STYLE_FILLCOLOR": _MXCOLOR.DEF,
            "STYLE_FONTCOLOR": _MXCOLOR.FONT,
            "STYLE_STROKECOLOR": _MXCOLOR.DEF,
            "STYLE_ROUNDED": true,
            "STYLE_ALIGN": mxConstants.ALIGN_LEFT,
            "STYLE_SPACING_LEFT": 20
        },
        //无图标
        "_none_sub": {
            "STYLE_STROKEWIDTH": 0,
            "STYLE_STROKECOLOR": null,
            "STYLE_IMAGE": ""
        },
        //被激活状态的文本
        "focus_txt": {
            "STYLE_FILLCOLOR": "#4285F4",
            "STYLE_STROKECOLOR": _MXCOLOR.STROKE
        },
        //普通节点
        "normal": {
            "STYLE_FILLCOLOR": _MXCOLOR.FILL,
            "STYLE_STROKECOLOR": _MXCOLOR.STROKE
        },
        "normal_sub": {
            "STYLE_STROKEWIDTH": 0,
            "STYLE_STROKECOLOR": null,
            "STYLE_IMAGE": _MXICON.DEL,
            "STYLE_SHAPE": mxConstants.SHAPE_LABEL,
            "STYLE_IMAGE_WIDTH": 20,
            "STYLE_IMAGE_HEIGHT": 20
        },
        "normal_num": {
            "STYLE_FILLCOLOR": _MXCOLOR.WHITER,
            "STYLE_FONTCOLOR": _MXCOLOR.BLACK,
            "STYLE_STROKECOLOR": _MXCOLOR.STROKE,
            "STYLE_SHAPE": mxConstants.SHAPE_ELLIPSE,
            "STYLE_ALIGN": mxConstants.ALIGN_CENTER,
            "STYLE_SPACING_LEFT": 0
        },
        //主节点
        "main": {
            "STYLE_ROUNDED": true,
            "STYLE_FILLCOLOR": _MXCOLOR.MAIN,
            "STYLE_STROKECOLOR": _MXCOLOR.MAIN,
            "STYLE_SPACING_LEFT": 30
        },
        "main_sub": {
            "STYLE_STROKEWIDTH": 0,
            "STYLE_STROKECOLOR": null,
            "STYLE_FILLCOLOR": _MXCOLOR.MAIN,
            "STYLE_SHAPE": mxConstants.SHAPE_LABEL
        },
        "main_num": {
            "STYLE_STROKECOLOR": _MXCOLOR.MAIN
        },
        //自关联节点
        "self": {
            "STYLE_FILLCOLOR": _MXCOLOR.MAIN,
            "STYLE_STROKECOLOR": _MXCOLOR.MAIN
        },
        "self_sub": {
            "STYLE_SHAPE": mxConstants.SHAPE_LABEL,
            "STYLE_IMAGE": _MXICON.DEL,
            "STYLE_IMAGE_WIDTH": 20,
            "STYLE_IMAGE_HEIGHT": 20
        },
        "self_num": {
            "STYLE_FILLCOLOR": _MXCOLOR.WHITER,
            "STYLE_FONTCOLOR": _MXCOLOR.BLACK,
            "STYLE_STROKECOLOR": _MXCOLOR.STROKE,
            "STYLE_SHAPE": mxConstants.SHAPE_ELLIPSE,
            "STYLE_ALIGN": mxConstants.ALIGN_CENTER,
            "STYLE_SPACING_LEFT": 0
        },
        //提示节点
        "empty": {
            "STYLE_FONTCOLOR": _MXCOLOR.EMPTY_FONT,
            "STYLE_FILLCOLOR": _MXCOLOR.EMPTY,
            "STYLE_DASHED": true,
            "STYLE_STROKEWIDTH": 1,
            "STYLE_STROKECOLOR": _MXCOLOR.EMPTY_FONT,
            "STYLE_FONTSIZE": '14'
        },
        "node_x": {
            "STYLE_SHAPE": mxConstants.SHAPE_LABEL,
            "STYLE_IMAGE": _MXICON.X,
            "STYLE_IMAGE_WIDTH": 20,
            "STYLE_IMAGE_HEIGHT": 20
        },
    };

    var defaultOptions = {
        nodeWidth: 170,
        nodeHeight: 40,
        onClickNode: function () {

        },
        onClearNodes: function () {

        },
        onClickEdge: function () {
        }
    };


    /**
     * 绘图类
     * @param {Node} container: 容器
     * @param {IUMLData} data 数据
     * @param {Void} options 配置
     */
    function MxGraph(container, data, options) {
        this.container = container;
        this.data = data || {};
        this.options = $.extend(defaultOptions, options || {});
        this.__INITED__ = false;
        var ctx = this;
        this.beforeInit(function () {
            ctx.init();
            ctx.draw();
            ctx.bindEvents();
            ctx.start();
        });
    }

    MxGraph.prototype = {
        refresh: function () {
            console.debug("refresh graph")
            this.graph.refresh();
        },
        beforeInit: function (cb) {
            // 判断浏览器兼容性
            if (!mxClient.isBrowserSupported()) {
                mxUtils.error('当前浏览器不支持！', 200, false);
            } else {
                cb();
            }
        },
        init: function () {
            //定义
            this.cfg = {
                mainNode: {},
                selfNode: {},
                nodes: {},
                edges: {}
            };
            this.cellStatus = {
                click: null,
                hover: null
            };
            // 新建画布
            var graph = this.graph = new mxGraph(this.container);
            //初始化样式
            this.initStyle(graph)
            // 禁止编辑
            graph.setEnabled(false);
            // 禁用折叠
            graph.foldingEnabled = false;
            // 内部cell 跟随 父cell 等比例缩放
            graph.recursiveResize = true;
            // 允许使用html labels
            graph.setHtmlLabels(true);

        },
        initStyle: function (graph) {
            //ALLSTYLE
            var allStyle = _MXSTYLE;
            for (var key in allStyle) {
                var styleObj = new Object();
                var styleSheet = allStyle[key];
                $.each(styleSheet, function (k, v) {
                    styleObj[mxConstants[k]] = v;
                });
                graph.getStylesheet().putCellStyle(key.toUpperCase(), styleObj);
            }

            // 设置节点默认样式
            var nodeStyle = graph.getStylesheet().getDefaultVertexStyle();
            $.each(allStyle._def, function (k, v) {
                nodeStyle[mxConstants[k]] = v;
            });
            var edgeStyle = graph.getStylesheet().getDefaultEdgeStyle();
            $.each(allStyle.normal_edge, function (k, v) {
                edgeStyle[mxConstants[k]] = v;
            });

        },
        draw: function () {
            var graph = this.graph;
            // 设置布局
            var layout = new mxParallelEdgeLayout(graph);
            var layoutMgr = new mxLayoutManager(graph);
            layoutMgr.getLayout = function (cell) {
                if (cell.getChildCount() > 0) {
                    return layout;
                }
            };
            this.renderData(this.data);
        },
        renderData: function (data) {
            var ctx = this;
            this.beforeInit(function () {
                var graph = ctx.graph;
                // 自定义渲染节点文本
                graph.convertValueToString = function (cell) {
                    if (cell && cell.isVertex(cell)) {
                        var value = cell.value || {};
                        var label = value.label || '';
                        var title = value.title || '';
                        var div = document.createElement('div');
                        div.innerHTML = label;
                        var sub = value.sub || '';
                        if (sub === "NORMAL" || sub === "MAIN" || sub === "SELF") {
                            div.setAttribute("title", title)
                        }
                        mxUtils.br(div);
                        return div;
                    }
                    return '';
                };
                var parent = graph.getDefaultParent();
                // 设置数据
                graph.getModel().beginUpdate();

                try {
                    var nodesArray = ctx.getNodeArray(data.nodes);
                    var edgesArray = data.edges || [];
                    var nodes = ctx.cfg.nodes;
                    $.each(nodesArray, function (i, d) {
                        if (d) {
                            if (d.level === 0) {
                                ctx.cfg.mainNode = d;
                                nodes[d.id] = ctx.drawComposeNode(graph, d, "main", i)
                            } else if (d.id === "self") {
                                ctx.cfg.selfNode = d;
                                nodes[d.id] = ctx.drawComposeNode(graph, d, "self", i)
                            } else {
                                nodes[d.id] = ctx.drawComposeNode(graph, d, "normal", i)
                            }
                        }
                    });

                    var edges = ctx.cfg.edges;
                    $.each(edgesArray, function (i, d) {
                        var style = d.target === "self" ? "SELF_EDGE" : "NORMAL_EDGE";
                        edges[d.target] = graph.insertEdge(parent, null, d, nodes[d.source], nodes[d.target], style);
                    });
                    //---------------------------add------------------------
                    ctx.drawEmptyNode(graph);
                    //--------------------------end-----------------------
                } finally {
                    // 渲染数据
                    graph.getModel().endUpdate();
                    // 画布居中
                    graph.center(true, true);
                }
            });

        },
        //绘制节点组合
        drawComposeNode: function (graph, node, type, idx) {
            console.debug("drawNode===", node, type, idx);
            if (node.level === 0) {
                return this.drawMainNode(graph, node, type, idx);
            }
            var parent = graph.getDefaultParent();

            var ctx = this;
            var options = ctx.options;
            var nodeWidth = options.nodeWidth;
            var nodeHeight = options.nodeHeight;
            var relationId = node.id;
            var x = (node.level || 0) * (nodeWidth) + 120;
            var y = idx * (nodeHeight + 20);

            var offset_x = 0;
            if (node.needModified) {
                offset_x = 30;
            }
            //root
            var rootNode = {"id": node.id, "label": "", "level": node.level, "sub": node.sub, "relation": relationId};
            var n0 = graph.insertVertex(parent, null, rootNode,
                x, y, nodeWidth + offset_x, nodeHeight,
                "_DEF"
            );
            //表单关联日志标红-#100455
            if (node.needModified) {
                //node_x
                var nodex = {
                    "id": node.id + "_node_x",
                    "label": "",
                    "level": 2,
                    "sub": "node_x",
                    "relation": relationId
                };
                graph.insertVertex(n0, null, nodex,
                    0, 0, offset_x, nodeHeight,
                    "NODE_X");
            }
            //txt
            var style = type.toUpperCase();    // var style_txt = style + "_TXT";
            var txtNode = {
                "id": node.id + "_txt",
                "label": "   " + node.label,
                "title": "   " + node.title,
                "level": "2",
                "sub": style,
                "relation": relationId
            };
            graph.insertVertex(n0, null, txtNode,
                offset_x, 0, 130, nodeHeight,
                style
            );
            //numberNode
            var style_number = style + "_NUM";
            var number = node.number || "0";
            var numberNode = {
                "id": node.id + "_number",
                "label": number,
                "level": 2,
                "sub": style_number,
                "relation": relationId
            };
            graph.insertVertex(n0, null, numberNode,
                offset_x + 120, 10, 20, 20,
                style_number);
            // subNode
            var style_sub = style + "_SUB";
            var subNode = {"id": node.id + "_sub", "label": "", "level": 2, "sub": style_sub, "relation": relationId};
            graph.insertVertex(n0, null, subNode,
                offset_x + 140, 12, 15, 15,
                "_NONE_SUB");

            return n0;
        },
        drawMainNode: function (graph, node, type, idx) {
            var parent = graph.getDefaultParent();
            var ctx = this;
            var options = ctx.options;
            var nodeWidth = options.nodeWidth;
            var nodeHeight = options.nodeHeight;
            var relationId = node.id;

            //root
            var rootNode = {"id": node.id, "label": "", "level": node.level, "sub": node.sub, "relation": relationId};
            var n0 = graph.insertVertex(parent, null, rootNode,
                0, 0, 130, nodeHeight,
                "_DEF"
            );
            //txt
            var style = type.toUpperCase();
            // var style_txt = style + "_TXT";
            var txtNode = {
                "id": node.id + "_txt",
                "label": node.label,
                "level": "2",
                "sub": style,
                "relation": relationId
            };
            var n1 = graph.insertVertex(n0, null, txtNode,
                0, 0, 130, nodeHeight,
                style
            );
            // subNode
            // var style_sub = style + "_SUB";
            // var subNode = {"id": node.id + "_sub", "label": "", "level": 2, "sub": style_sub, "relation": relationId};
            // var n2 = graph.insertVertex(n0, null, subNode,
            //     80, 10, 14, 17,
            //     style_sub);

            return n0;
        },
        drawEmptyNode: function (graph) {
            var emptyNode = {"id": "emptyNode", "label": modelingLang['relation.drag.right.area'], "image": "", "level": 1};
            var parent = graph.getDefaultParent();
            var options = this.options;
            var nodeWidth = options.nodeWidth;
            var nodeHeight = options.nodeHeight;
            this.cfg.nodes[emptyNode.id] = graph.insertVertex(
                parent,
                null,
                emptyNode,
                290,
                nodeHeight * -0.5,
                180,
                40,
                "EMPTY"
            );
        },
        //追加节点
        appendNode: function (newNode) {
            var dataNodes = this.data.nodes;
            var mainNode = this.getMainNode();
            if (newNode.id === mainNode.id) {
                newNode.id = "self";
            }
            //去重
            for (var i in dataNodes) {
                var node = dataNodes[i];
                if (node.id === newNode.id) {
                    return;
                }
            }
            dataNodes.push(newNode);
            //构建-线
            var dataEdges = this.data.edges;
            var newEdge = {"source": mainNode.id, "target": newNode.id};
            dataEdges.push(newEdge);
            this.data.edges = dataEdges;
            this.clearNodes();
            this.renderData(this.data);
            //新建后自动触发
            var newCell = this.cfg.nodes[newNode.id];
            this.options.onClickNode(newCell.getValue());
            this.setHoverAndFocusStyle(newCell, "click");

        },
        //更新图中节点的数字
        updateNodeNumber: function (passiveId, number, type) {
            // console.log("updateNodeNumber", passiveId, number, type);
            var dataNodes = this.data.nodes;
            var mainNode = this.getMainNode();
            if (passiveId === mainNode.id) {
                passiveId = "self";
            }
            //选中节点
            var selectedNodeIdx = null;
            for (var i in dataNodes) {
                var node = dataNodes[i];
                if (node.id === passiveId) {
                    selectedNodeIdx = i;
                    break;
                }
            }
            if (selectedNodeIdx) {
                var oldNumber = this.data.nodes[selectedNodeIdx].number;
                oldNumber = parseInt(oldNumber)
                if (type === "plus") {
                    number = oldNumber + number;
                } else if (type === "minus") {
                    number = oldNumber - number;
                }
                number = "" + number;
                this.data.nodes[selectedNodeIdx].number = number;
                this.clearNodes();
                this.renderData(this.data);
                var newCell = this.cfg.nodes[passiveId];
                this.options.onClickNode(newCell.getValue(), true);
                this.setHoverAndFocusStyle(newCell, "click");

            }
        },
        //删除节点 方便主页面回调
        delNode: function (id) {
            var nodes = this.cfg.nodes;
            var edges = this.cfg.edges;
            var graph = this.graph;
            var cellNode = nodes[id];
            cellNode.removeFromParent();
            graph.refresh(cellNode);
            for (var i = 0; i < this.data.nodes.length; i++) {
                if (id === this.data.nodes[i].id) {
                    this.data.nodes.splice(i, 1);
                    break;
                }
            }
            var cellEdge = edges[id];
            if (cellEdge) {
                cellEdge.removeFromParent();
                graph.refresh(cellEdge);
                for (var i in this.data.edges) {
                    if (id === this.data.edges[i].target) {
                        this.data.edges.splice(i, 1);
                        break;
                    }
                }
            }
            //删除后回到选择

            this.options.onClickNode(this.getMainNode());
            return cellNode;
        },
        //清除图
        clearNodes: function (id) {
            var nodes = this.cfg.nodes;
            var edges = this.cfg.edges;
            var graph = this.graph;
            if (id) {
                //调起主页面
                this.options.onClearNodes(id);
            } else {//all
                for (var k in nodes) {
                    var cellNode = nodes[k];
                    cellNode.removeFromParent();
                    graph.refresh(cellNode);
                    var cellEdge = edges[k];
                    if (cellEdge) {
                        cellEdge.removeFromParent();
                        graph.refresh(cellEdge);
                    }
                }
            }


        },
        //时间绑定,触发回调函数,与样式改变
        bindEvents: function () {
            var self = this;
            var options = self.options;
            var onClickNode = options.onClickNode;
            var onClickEdge = options.onClickEdge;
            // 新增点击事件
            self.graph.addListener(mxEvent.CLICK, function (source, evt) {
                var cell = evt.getProperty('cell');
                if (!cell) {
                    return;
                }
                if (cell.isVertex(cell)) {
                    self.setHoverAndFocusStyle(cell, "click");
                    onClickNode && onClickNode(cell.value || {});
                } else if (cell.isEdge(cell)) {
                    onClickEdge && onClickEdge(cell.value || {});
                } else {
                    // DO NOTHING
                }
            });
            //设置导航图的任务节点的鼠标与移入移出效果
            var track = new mxCellTracker(this.graph);
            //mouseEnd  mouseLeave
            track.mouseMove = function (sender, me) {
                var cell = this.getCell(me);
                if (cell) {
                    //设置鼠标为样式为手状
                    me.getState().setCursor('pointer');
                    self.setHoverAndFocusStyle(cell, "mouseEntry");
                } else {
                    //设置鼠标移出节点效果
                    self.setHoverAndFocusStyle(cell, "mouseLeave");
                }
            };
        },
        //设置选中的样式
        setHoverAndFocusStyle: function (cell, event) {

            var self = this;
            //这两个cell 都是设置成父节点,用来记录当前状态的内容
            var clickCell = self.cellStatus.click;
            var hoverCell = self.cellStatus.hover;
            //拿节点
            var cc, hc = null;
            if (cell == null) {
                if (event === "mouseLeave") {
                    if (!hoverCell) {
                        //不处理
                        return;
                    }
                    hc = hoverCell;
                }
            } else {
                var cellLevel = cell.getValue().level;
                if (cellLevel != 1 && cellLevel != 2) {
                    //不属于子节点（1，2级别的）的不处理
                    return;
                }
                var parentCell = cellLevel === 1 ? cell : cell.parent;
                //处理主节点
                if (parentCell.getValue().level == 0) {
                    return;
                }
                //非空
                if (event === "click") {
                    cc = parentCell
                } else if (event === "mouseEntry") {
                    hc = parentCell
                } else if (event === "mouseLeave") {
                    hc = parentCell
                }
            }

            //#1 离开
            if (event === "mouseLeave") {
                if (hc != clickCell) {
                    self.cellActive(hc, false);
                }
                self.cellStatus.hover = null;
            } else if (event === "mouseEntry") {
                if (hc == hoverCell) {
                    return;
                }
                self.cellActive(hc, true);
                if (hoverCell != clickCell) {
                    self.cellActive(hoverCell, false);
                }
                self.cellStatus.hover = hc;
            } else if (event === "click") {
                if (cc == clickCell) {
                    return;
                }
                self.cellActive(cc, true);
                self.cellActive(clickCell, false);
                self.cellStatus.click = cc;
            } else {
                //other
                return;
            }
        },
        cellActive: function (cell, isActive) {
            if (!cell || !cell.children) {
                return;
            }
            var self = this;
            var model = self.graph.getModel();
            model.beginUpdate();
            try {
                if (isActive) {
                    //显示
                    $.each(cell.children, function (idx, itemCell) {
                        //#1 icon
                        if (itemCell.style.indexOf("_SUB") > 0) {
                            var style = itemCell.getValue().sub;
                            itemCell.style = style;
                            self.graph.refresh(itemCell);
                        }
                        //#2设置字体变色背景
                        if (itemCell.getValue().id.indexOf("_txt") > 0) {

                            itemCell.style = "FOCUS_TXT";
                            self.graph.refresh(itemCell);
                        }
                    });
                } else {
                    //隐藏
                    $.each(cell.children, function (idx, itemCell) {
                        //#1 icon
                        if (itemCell.style.indexOf("_SUB") > 0) {
                            itemCell.style = "_NONE_SUB";
                            self.graph.refresh(itemCell);
                        }
                        //#2设置字体变色背景
                        if (itemCell.getValue().id.indexOf("_txt") > 0) {
                            var style = itemCell.getValue().sub;
                            itemCell.style = style;
                            self.graph.refresh(itemCell);
                        }
                    });
                }

            } finally {
                model.endUpdate();
            }
        },
        moveNode: function (cell, isLeave) {
            var self = this;
            var model = self.graph.getModel();
            model.beginUpdate();
            try {
                if (cell == null || isLeave) {
                    //为空不处理鼠标事件 原来
                    if (self.mouseInCell && self.mouseInCell != {}) {
                        self.mouseInCell.style = "_NONE_SUB";
                        self.graph.refresh(self.mouseInCell);
                    }
                } else {
                    //显示
                    var parentCell = cell.getParent();
                    if (parentCell && parentCell.getValue() && parentCell.getValue().level === 1) {
                        $.each(parentCell.children, function (idx, itemCell) {
                            if (self.mouseInCell != itemCell && itemCell.style.indexOf("_SUB") > 0) {
                                var style = itemCell.getValue().sub;
                                itemCell.style = style;
                                self.mouseInCell = itemCell;
                                self.graph.refresh(self.mouseInCell);
                            }
                        });

                    }
                }
                //_none_sub  var style = cell.getValue().get
                self.graph.setCellStyles("strokeColor", [cell]);
            } finally {
                model.endUpdate();
            }
        },
        start: function () {
            // DO NOTHING
        },
        //prototypes--get
        getMainNode: function () {
            return this.cfg.mainNode;
        },
        putNode: function (key, value) {
            var nodes = this.cfg.mainNode;
            nodes[key] = value;
        },
        getNodeArray: function (nodes) {
            var nodesArray = (nodes || []);
            var l = nodesArray.length, i, j;
            for (i = 0; i < l; i++) {
                var l1 = (nodesArray[i].level || 0);
                for (j = i + 1; j < l; j++) {
                    var l2 = (nodesArray[j].level || 0);
                    if (l2 < l1) {
                        var t = nodesArray[i];
                        nodesArray[i] = nodesArray[j];
                        nodesArray[j] = t;
                    }
                }
            }
            return nodesArray;
        },
        getAllRelationNumber: function () {
            var nodes = this.data.nodes;
            var allRelationNumber = 0;
            for (var i in nodes) {
                var item = nodes[i];
                if (item && item.level === 1 && item.number) {
                    allRelationNumber += parseInt(item.number);
                }
            }
            return allRelationNumber;
        },
        getAllFillingNumber: function (widgetId) {
            var nodes = this.data.nodes;
            var allFillingNumber = 0;
            for (var i in nodes) {
                var item = nodes[i];
                if (item && item.level === 1 && item.widgetInfos) {
                    for (var key in item.widgetInfos) {
                        var info = item.widgetInfos[key];
                        if(widgetId && key != widgetId){
                            continue;
                        }
                        if(info.type == "2") {
                            allFillingNumber += parseInt(info.count);
                        }
                    }
                }
            }
            return allFillingNumber;
        },
        getRelationNumber: function () {
            var nodes = this.data.nodes;
            var allRelationNumber = 0;
            for (var i in nodes) {
                var item = nodes[i];
                if (item && item.level === 1 && item.widgetInfos) {
                    for (var key in item.widgetInfos) {
                        var info = item.widgetInfos[key];
                        if(info.type != "2") {
                            allRelationNumber += parseInt(info.count);
                        }
                    }
                }
            }
            return allRelationNumber;
        },

    };

    module.exports = MxGraph

})
;