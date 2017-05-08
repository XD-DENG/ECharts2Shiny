(function (root, factory) {if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define(['exports', 'echarts'], factory);
    } else if (typeof exports === 'object' && typeof exports.nodeName !== 'string') {
        // CommonJS
        factory(exports, require('echarts'));
    } else {
        // Browser globals
        factory({}, root.echarts);
    }
}(this, function (exports, echarts) {
    var log = function (msg) {
        if (typeof console !== 'undefined') {
            console && console.error && console.error(msg);
        }
    };
    if (!echarts) {
        log('ECharts is not Loaded');
        return;
    }
	// Theme inspired by http://www.colourlovers.com/palette/41805/cobblestone_jazz
    var colorPalette = [
        '#e9e0d1','#91a398','#33605a','#070001',
        '#68462b','#58a79c','#abd3ce','#eef6f5'
    ];

    var theme = {

        color: colorPalette,

        title: {
            textStyle: {
                fontWeight: 'normal',
				color: '#e9e0d1'
            }
        },

        visualMap: {
            color:['#e9e0d1','#a2d4e6']
        }, 

        toolbox: {
            color : ['#e9e0d1','#e9e0d1','#e9e0d1','#e9e0d1']
        },

    tooltip: {
        backgroundColor: 'rgba(0,0,0,0.5)',
        axisPointer : {            // Axis indicator, coordinate trigger effective
            type : 'line',         // The default is a straight line： 'line' | 'shadow'
            lineStyle : {          // Straight line indicator style settings
                color: '#e9e0d1',
                type: 'dashed'
            },
            crossStyle: {
                color: '#e9e0d1'
            },
            shadowStyle : {                     // Shadow indicator style settings
                color: 'rgba(200,200,200,0.3)'
            }
        }
    },

    // Area scaling controller
    dataZoom: {
        dataBackgroundColor: '#eee',            // Data background color
        fillerColor: 'rgba(144,197,237,0.2)',   // Fill the color
        handleColor: '#e9e0d1'     // Handle color
    },

    timeline : {
        lineStyle : {
            color : '#e9e0d1'
        },
        controlStyle : {
            normal : { color : '#e9e0d1'},
            emphasis : { color : '#e9e0d1'}
        }
    },

	k: {
        itemStyle: {
            normal: {
                color: '#91a398',          // Yang line filled with color
                color0: '#33605a',      // Yinxian fill color
                lineStyle: {
                    width: 1,
                    color: '#68462b',   // Yang line border color
                    color0: '#070001'   // Yinbian border color
                }
            }
        }
    },

        candlestick: {
            itemStyle: {
                normal: {
                    color: '#e9e0d1',
                    color0: '#a2d4e6',
                    lineStyle: {
                        width: 1,
                        color: '#e9e0d1',
                        color0: '#a2d4e6'
                    }
                }
            }
        },

        graph: {
            color: colorPalette
        },

        map: {
        itemStyle: {
            normal: {
                areaStyle: {
                    color: '#ddd'
                },
                label: {
                    textStyle: {
                        color: '#c12e34'
                    }
                }
            },
            emphasis: {                 // Is also selected style
                areaStyle: {
                    color: '#33605a'
                },
                label: {
                    textStyle: {
                        color: '#c12e34'
                    }
                }
            }
        }
    },

	force : { 
        itemStyle: {
            normal: {
                linkStyle : {
                    color : '#e9e0d1'
                }
            }
        }
    },

        gauge : {
        axisLine: {            // Coordinate axis
            show: true,        // Default display, property show control display or not
            lineStyle: {       // Attribute lineStyle controls the line style
                color: [[0.2, '#91a398'],[0.8, '#e9e0d1'],[1, '#68462b']], 
                width: 8
            }
        },
        axisTick: {            // Small mark of the axis
            splitNumber: 10,   // How many segments per split subdivision
            length :12,        // Attribute length control line length
            lineStyle: {       // Attribute lineStyle controls the line style
                color: 'auto'
            }
        },
        axisLabel: {           // Axis text label, see details axis.axisLabel
            textStyle: {       // The remaining attributes use the global text style by default TEXTSTYLE
                color: 'auto'
            }
        },
        splitLine: {           // Separate lines
            length : 18,         // Attribute length control line length
            lineStyle: {       // The attribute lineStyle (see lineStyle for details) controls the line style
                color: 'auto'
            }
        },
        pointer : {
            length : '90%',
            color : 'auto'
        },
        title : {
            textStyle: {       // The remaining attributes use the global text style by default TEXTSTYLE
                color: '#333'
            }
        },
        detail : {
            textStyle: {       // The remaining attributes use the global text style by default TEXTSTYLE
                color: 'auto'
            }
        }
    }
  };
    echarts.registerTheme('jazz', theme);
}));