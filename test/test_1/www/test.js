

var pie_CASE_D = echarts.init(document.getElementById('Weekly_Total_1'));

option_pie_CASE_D = {

       tooltip : {
           trigger: 'item',
           formatter: "{a} <br/>{b} : {c} ({d}%)"
       },
       series : [
           {
           		name: 'D',
               type: 'pie',
               radius : '40%',
               center: ['50%', '40%'],
               data: [{"X":"a", "y":1}, {"X":"b", "Y":3}],
               itemStyle: {
                   emphasis: {
                       shadowBlur: 10,
                       shadowOffsetX: 0,
                       shadowColor: 'rgba(0, 0, 0, 0.5)'
                   }
               }
           }
       ]
   };
pie_CASE_D.setOption(option_pie_CASE_D);

