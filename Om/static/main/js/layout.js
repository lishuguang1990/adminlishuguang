$(function () {
    //nav滚动条
    $('nav').niceScroll({
        cursorcolor: "#424242",
        cursoropacitymin: 0,
        cursoropacitymax: 1,
        cursorwidth: "5px",
        cursorborder: "0px",
        cursorborderradius: "5px",
        scrollspeed: 60,
        mousescrollstep: 40,
        touchbehavior: false,
        autohidemode: true
    })

    //下拉框滚动条
    $('.select-option').niceScroll({
        cursorcolor: "#b45f1a",
        cursoropacitymin: 0,
        cursoropacitymax: 1,
        cursorwidth: "5px",
        cursorborder: "0px",
        cursorborderradius: "5px",
        scrollspeed: 60,
        mousescrollstep: 40,
        touchbehavior: false,
        autohidemode: true
    })
})

//接口请求地址
var ajax_url = 'http://linken01.ourmod.net';

//时间选择器初始化
function datePickerInit(id) {
    $('#' + id).datepicker({
        dateFormat: 'yy-mm-dd',
        prevText: "&#x3c;上月",
        nextText: "下月&#x3e;",
        currentText: "今天",
        monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
        monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"],
        dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
        dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
        dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"],
        weekHeader: "周"
    });
}

//日期验证
function dateVertify() {
    var starttime = $('#date_1').val();
    var endtime = $('#date_2').val();

    var d1 = new Date(starttime.replace(/\-/g, "\/"));
    var d2 = new Date(endtime.replace(/\-/g, "\/"));
    
    if (starttime == '') {
        alert('起始时间不能为空');
        return false;
    } else if (endtime == '') {
        alert('结束时间不能为空');
        return false;
    } else if(d1>d2) {
        alert('开始时间不能大于结束时间');
        return false;
    } else {
        return true;
    }
}

//模拟下拉框
function selectBox() {
    $('.select-show').on('click', function () {
        if ($(this).parent().hasClass('active')) {
            $(this).parent().removeClass('active');
            $(this).parent().find('.select-option').slideUp(300);
        } else {
            $(this).parent().addClass('active');
            $(this).parent().find('.select-option').slideDown(300);            
        }
    })

    $('.select-option').on('click', 'span', function () {
        var selected = $(this).html();
        $(this).parent().parent().find('.select-show').html(selected);
        $(this).parent().parent().removeClass('active');
        $(this).parent().slideUp(300);
    })

    $('body').click(function (e) {
        var _con = $('.select-box');
        if (!_con.is(e.target) && _con.has(e.target).length === 0) {
            _con.removeClass('active');
            _con.find('.select-option').slideUp(300);
        }
    })
}

//活动场次汇总
function activitiesSummary() {
    datePickerInit('date_1');
    datePickerInit('date_2');

    $('.check-btn').click(function () {
        if (dateVertify()) {
            $.ajax({
                type: "post",
                url: ajax_url + '/api/apiactivitychart/getactivitytypestatisticslist',
                data: { begintime: $('#date_1').val(), endtime: $('#date_2').val() },
                success: function (data) {                    
                    var datalist = new Array();
                    datalist.push(data.result.total);
                    for (var i = 0; i < data.result.list.length - 1; i++) {
                        datalist.push(data.result.list[i].quantity);
                    }
                    datalist.reverse();
                    console.log(datalist);

                    myChart.setOption({
                        series: [{
                            data: datalist,
                            type: 'bar',
                            itemStyle: {
                                normal: {
                                    color: function (params) {
                                        var colorList = ['#7abac2', '#e68361', '#d55c59', '#2f4554'];
                                        return colorList[params.dataIndex]
                                    },
                                    label: { show: true, position: 'right' }
                                }
                            }
                        }]
                    });
                }
            })
        }
    })

    var myChart = echarts.init(document.getElementById('main'));

    option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        xAxis: {            
            type: 'value'
        },
        yAxis: {            
            type: 'category',
            data: ['职业类场次', '派对类场次', '爱好类场次', '活动总场次'],
            axisLabel: {
                show: true,
                textStyle: {
                    fontSize: 16,
                    color: '#333'
                }
            }
        },
        series: [{
            data: [300, 200, 150, 80],
            type: 'bar',
            itemStyle: {
                normal: {                    
                    color: function (params) {                        
                        var colorList = ['#7abac2', '#e68361', '#d55c59', '#2f4554'];
                        return colorList[params.dataIndex]
                    },
                    label : {show: true, position: 'right'}
                }                
            }            
        }]
    };

    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/getactivitytypestatisticslist',
        data: {begintime: '', endtime: ''},
        success: function (data) {
            myChart.hideLoading();
            myChart.setOption(option);

            var datalist = new Array();
            datalist.push(data.result.total);
            for (var i = 0; i < data.result.list.length - 1; i++) {
                datalist.push(data.result.list[i].quantity);
            }
            datalist.reverse();

            myChart.setOption({
                series: [{
                    data: datalist,
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: function (params) {
                                var colorList = ['#7abac2', '#e68361', '#d55c59', '#2f4554'];
                                return colorList[params.dataIndex]
                            },
                            label: { show: true, position: 'right' }
                        }
                    }
                }]
            });
        }
    });    
}

//每月不同类型活动场次及成本统计
function averageCost() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthaveragecost',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var hobbyList = new Array(); //爱好类活动场次列表
            var partyList = new Array(); //派对类活动场次列表
            var jobList = new Array(); //职业类活动场次列表

            var hobbyCostList = new Array(); //爱好类场均成本列表
            var partyCostList = new Array(); //派对类场均成本列表
            var jobCostList = new Array(); //职业类场均成本列表
            var averageCostList = new Array(); //活动均成本列表
            var summaryList = new Array();

            for (var i = 0; i < data.allaveragelist.length; i++) {
                var month = data.allaveragelist[i].nmonth + '月';
                if (monthList.indexOf(month) == -1) {
                    monthList.push(month);
                    summaryList.push({
                        nmonth: month.substr(0, month.length - 1),
                        average: data.allaveragelist[i].average,
                        hobby: 0,
                        party: 0,
                        job: 0                        
                    });
                }
                averageCostList.push(data.allaveragelist.average);
            }

            //设置数组默认值, 占满x轴长度
            for (var i = 0; i < monthList.length; i++) {
                hobbyList.push(0);
                partyList.push(0);
                jobList.push(0);

                hobbyCostList.push(0);
                partyCostList.push(0);
                jobCostList.push(0);

                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);            
            
            for (var i = 0; i < data.averagebytypelist.length; i++) {
                if (data.averagebytypelist[i].saleactivitytypeid == 2) {
                    var index = monthList.indexOf(data.averagebytypelist[i].month + '月');
                    hobbyList[index] = data.averagebytypelist[i].count;
                    hobbyCostList[index] = data.averagebytypelist[i].average;
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 1) {
                    partyList[index] = data.averagebytypelist[i].count;
                    partyCostList[index] = data.averagebytypelist[i].average;
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 3) {
                    jobList[index] = data.averagebytypelist[i].count;
                    jobCostList[index] = data.averagebytypelist[i].average;
                }                
                
                for (var j = 0; j < summaryList.length; j++) {                  
                    if (summaryList[j].nmonth == data.averagebytypelist[i].month) {                        
                        switch (data.averagebytypelist[i].saleactivitytypeid) {
                            case 2:
                                summaryList[j].hobby = data.averagebytypelist[i].count;
                                break;
                            case 1:
                                summaryList[j].party = data.averagebytypelist[i].count;
                                break;
                            case 3:
                                summaryList[j].job = data.averagebytypelist[i].count;
                                break;
                        }                        
                    }
                }                
            }

            for (var i = 0; i < summaryList.length; i++) {
                summaryList[i].total = summaryList[i].hobby + summaryList[i].job + summaryList[i].party;
            }

            $('.summary-total em').html(summaryList[0].total);
            $('.summary-hobby em').html(summaryList[0].hobby);
            $('.summary-party em').html(summaryList[0].party);
            $('.summary-job em').html(summaryList[0].job);
            $('.summary-average em').html(summaryList[0].average);

            //月份筛选
            $('.select-option').on('click', 'span', function () {                
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-total em').html(summaryList[i].total);
                        $('.summary-hobby em').html(summaryList[i].hobby);
                        $('.summary-party em').html(summaryList[i].party);
                        $('.summary-job em').html(summaryList[i].job);
                        $('.summary-average em').html(summaryList[i].average);
                    }
                }
            })
            
            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['爱好类活动', '派对类活动', '职业类活动', '爱好类场均成本', '派对类场均成本', '职业类场均成本', '活动均成本']
                },
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: 'CNY',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }, {
                    type: 'value',
                    name: '场次',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }],
                series: [{
                    name: '爱好类活动',
                    type: 'bar',
                    yAxisIndex: 1,
                    data: hobbyList
                }, {
                    name: '派对类活动',
                    type: 'bar',
                    yAxisIndex: 1,
                    data: partyList
                }, {
                    name: '职业类活动',
                    type: 'bar',
                    yAxisIndex: 1,
                    data: jobList
                }, {
                    name: '爱好类场均成本',
                    type: 'line',
                    data: hobbyCostList
                }, {
                    name: '派对类场均成本',
                    type: 'line',
                    data: partyCostList
                }, {
                    name: '职业类场均成本',
                    type: 'line',
                    data: jobCostList
                }, {
                    name: '活动均成本',
                    type: 'line',
                    data: averageCostList
                }]
            })
        }
    });
}

//活动场均客流统计
function averagePassengerFlow() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthaveragepassengerflow',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var hobbyList = new Array(); //爱好类客流列表
            var partyList = new Array(); //派对类客流列表
            var jobList = new Array(); //职业类客流列表
            var summaryList = new Array();

            for (var i = 0; i < data.alltotallist.length; i++) {
                var month = data.alltotallist[i].nmonth + '月';
                if (monthList.indexOf(month) == -1) {
                    monthList.push(month);
                    summaryList.push({
                        nmonth: month.substr(0, month.length - 1),
                        total: data.alltotallist[i].totalpassengerflow,
                        hobby: 0,
                        party: 0,
                        job: 0
                    });
                }
            }

            //设置数组默认值, 占满x轴长度
            for (var i = 0; i < monthList.length; i++) {
                hobbyList.push(0);
                partyList.push(0);
                jobList.push(0);

                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            for (var i = 0; i < data.averagebytypelist.length; i++) {
                if (data.averagebytypelist[i].saleactivitytypeid == 2) {
                    var index = monthList.indexOf(data.averagebytypelist[i].month + '月');
                    hobbyList[index] = data.averagebytypelist[i].average;
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 1) {
                    var index = monthList.indexOf(data.averagebytypelist[i].month + '月');
                    partyList[index] = data.averagebytypelist[i].average;
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 3) {
                    var index = monthList.indexOf(data.averagebytypelist[i].month + '月');
                    jobList[index] = data.averagebytypelist[i].average;
                }

                for (var j = 0; j < summaryList.length; j++) {
                    if (summaryList[j].nmonth == data.averagebytypelist[i].month) {
                        switch (data.averagebytypelist[i].saleactivitytypeid) {
                            case 2:
                                summaryList[j].hobby = data.averagebytypelist[i].totalpassengerflow;
                                break;
                            case 1:
                                summaryList[j].party = data.averagebytypelist[i].totalpassengerflow;
                                break;
                            case 3:
                                summaryList[j].job = data.averagebytypelist[i].totalpassengerflow;
                                break;
                        }
                    }
                }
            }

            $('.summary-hobby em').html(summaryList[0].hobby);
            $('.summary-party em').html(summaryList[0].party);
            $('.summary-job em').html(summaryList[0].job);
            $('.summary-average em').html(summaryList[0].total);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-hobby em').html(summaryList[i].hobby);
                        $('.summary-party em').html(summaryList[i].party);
                        $('.summary-job em').html(summaryList[i].job);
                        $('.summary-average em').html(summaryList[i].total);
                    }
                }
            })

            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['爱好类活动场均客流', '派对类活动场均客流', '职业类活动场均客流']
                },
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: '人次',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }],
                series: [{
                    name: '爱好类活动场均客流',
                    type: 'bar',
                    data: hobbyList,
                    itemStyle: {
                        normal: {                            
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动场均客流',
                    type: 'bar',
                    data: partyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动场均客流',
                    type: 'bar',
                    data: jobList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }]
            })
        }
    });
}

//活动平均订单数量统计
function averageOrder() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthaverageorder',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array();
            var str = '';

            var hobbyList = new Array(); //爱好类现场订单列表
            var partyList = new Array(); //派对类现场订单列表
            var jobList = new Array(); //职业类现场订单列表

            var hobbyLaterList = new Array(); //爱好类后续订单列表
            var partyLaterList = new Array(); //派对类后续订单列表
            var jobLaterList = new Array(); //职业类后续订单列表 

            var summaryList = new Array(); //每月活动订单数统计

            for (var i = 0; i < data.averagelist.length; i++) {
                var month = data.averagelist[i].nmonth + '月';
                if (monthList.indexOf(month) == -1) {
                    monthList.push(month);
                    summaryList.push({
                        nmonth: month.substr(0, month.length - 1),
                        hobby: 0,
                        party: 0,
                        job: 0
                    });
                }
            }
            console.log('monthList', monthList);

            //设置数组默认值, 占满x轴长度
            for (var i = 0; i < monthList.length; i++) {
                hobbyList.push(0);
                partyList.push(0);
                jobList.push(0);

                hobbyLaterList.push(0);
                partyLaterList.push(0);
                jobLaterList.push(0);

                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            for (var i = 0; i < data.averagelist.length; i++) {
                if (data.averagelist[i].saleactivitytypeid == 2) {
                    var index = monthList.indexOf(data.averagelist[i].nmonth + '月');
                    hobbyList[index] = data.averagelist[i].orderquantityaverage;
                    hobbyLaterList[index] = data.averagelist[i].laterorderquantityaverage
                }
                if (data.averagelist[i].saleactivitytypeid == 1) {
                    var index = monthList.indexOf(data.averagelist[i].nmonth + '月');
                    partyList.push(data.averagelist[i].orderquantityaverage);
                    partyLaterList.push(data.averagelist[i].laterorderquantityaverage);
                }
                if (data.averagelist[i].saleactivitytypeid == 3) {
                    jobList.push(data.averagelist[i].orderquantityaverage);
                    jobLaterList.push(data.averagelist[i].laterorderquantityaverage);
                }
                
                for (var j = 0; j < summaryList.length; j++) {
                    if (summaryList[j].nmonth == data.averagelist[i].nmonth) {
                        switch (data.averagelist[i].saleactivitytypeid) {
                            case 2:
                                summaryList[j].hobby = data.averagelist[i].orderquantityaverage + data.averagelist[i].laterorderquantityaverage;
                                break;
                            case 1:
                                summaryList[j].party = data.averagelist[i].orderquantityaverage + data.averagelist[i].laterorderquantityaverage;
                                break;
                            case 3:
                                summaryList[j].job = data.averagelist[i].orderquantityaverage + data.averagelist[i].laterorderquantityaverage;
                                break;
                        }
                    }
                }
            }            

            for (var i = 0; i < monthList.length; i++) {
                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            for (var i = 0; i < summaryList.length; i++) {
                summaryList[i].total = summaryList[i].hobby + summaryList[i].job + summaryList[i].party;
            }

            console.log(summaryList);

            $('.summary-hobby em').html(summaryList[0].hobby);
            $('.summary-party em').html(summaryList[0].party);
            $('.summary-job em').html(summaryList[0].job);
            $('.summary-total em').html(summaryList[0].total);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-total em').html(summaryList[i].total);
                        $('.summary-hobby em').html(summaryList[i].hobby);
                        $('.summary-party em').html(summaryList[i].party);
                        $('.summary-job em').html(summaryList[i].job);
                    }
                }
            })

            option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['爱好类活动现场订单', '派对类活动现场订单', '职业类活动现场订单', '爱好类活动后续订单', '派对类活动后续订单', '职业类活动后续订单']
                },                
                xAxis: [
                    {
                        type: 'category',
                        data: monthList
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '爱好类活动现场订单',
                        type: 'bar',
                        stack: 'hobby',
                        data: hobbyList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    },
                    {
                        name: '爱好类活动后续订单',
                        type: 'bar',
                        stack: 'hobby',
                        data: hobbyLaterList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    },
                    {
                        name: '派对类活动现场订单',
                        type: 'bar',
                        stack: 'party',
                        data: partyList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    },
                    {
                        name: '派对类活动后续订单',
                        type: 'bar',
                        stack: 'party',
                        data: partyLaterList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    },                    
                    {
                        name: '职业类活动现场订单',
                        type: 'bar',
                        stack: 'job',
                        data: jobList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    },
                    {
                        name: '职业类活动后续订单',
                        type: 'bar',
                        stack: 'job',
                        data: jobLaterList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'inside' }
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option);
        }
    });
}

//活动平均潜客统计
function averageLatentPassengerFlow() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthaveragelatentpassengerflow',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array();
            var str = '';

            var hobbyList = new Array(); //爱好类现场订单列表
            var partyList = new Array(); //派对类现场订单列表
            var jobList = new Array(); //职业类现场订单列表

            var summaryList = new Array(); //每月活动订单数统计

            for (var i = 0; i < data.averagelist.length; i++) {
                if (data.averagelist[i].saleactivitytypeid == 2) {
                    hobbyList.push(data.averagelist[i].latentpassengerflowaverage);
                }
                if (data.averagelist[i].saleactivitytypeid == 1) {
                    partyList.push(data.averagelist[i].latentpassengerflowaverage);
                }
                if (data.averagelist[i].saleactivitytypeid == 3) {
                    jobList.push(data.averagelist[i].latentpassengerflowaverage);
                }

                var month = data.averagelist[i].nmonth + '月';
                if (monthList.indexOf(month) == -1) {
                    monthList.push(month);
                    summaryList.push({
                        nmonth: month.substr(0, month.length - 1),
                        hobby: 0,
                        party: 0,
                        job: 0
                    });
                }


                for (var j = 0; j < summaryList.length; j++) {
                    if (summaryList[j].nmonth == data.averagelist[i].nmonth) {
                        switch (data.averagelist[i].saleactivitytypeid) {
                            case 2:
                                summaryList[j].hobby = data.averagelist[i].latentpassengerflowaverage;
                                break;
                            case 1:
                                summaryList[j].party = data.averagelist[i].latentpassengerflowaverage;
                                break;
                            case 3:
                                summaryList[j].job = data.averagelist[i].latentpassengerflowaverage;
                                break;
                        }
                    }
                }
            }

            for (var i = 0; i < monthList.length; i++) {
                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            for (var i = 0; i < summaryList.length; i++) {
                summaryList[i].total = summaryList[i].hobby + summaryList[i].job + summaryList[i].party;
            }

            console.log(summaryList);

            $('.summary-hobby em').html(summaryList[0].hobby);
            $('.summary-party em').html(summaryList[0].party);
            $('.summary-job em').html(summaryList[0].job);
            $('.summary-total em').html(summaryList[0].total);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-total em').html(summaryList[i].total);
                        $('.summary-hobby em').html(summaryList[i].hobby);
                        $('.summary-party em').html(summaryList[i].party);
                        $('.summary-job em').html(summaryList[i].job);
                    }
                }
            })

            option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['爱好类活动平均潜客人数', '派对类活动平均潜客人数', '职业类活动平均潜客人数']
                },
                xAxis: [
                    {
                        type: 'category',
                        data: monthList
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        name: '人数'
                    }
                ],
                series: [
                    {
                        name: '爱好类活动平均潜客人数',
                        type: 'bar',
                        data: hobbyList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'top' }
                            }
                        }
                    },
                    {
                        name: '派对类活动平均潜客人数',
                        type: 'bar',
                        data: partyList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'top' }
                            }
                        }
                    },
                    {
                        name: '职业类活动平均潜客人数',
                        type: 'bar',
                        data: jobList,
                        itemStyle: {
                            normal: {
                                label: { show: true, position: 'top' }
                            }
                        }
                    }]
            };
            myChart.setOption(option);
        }
    });
}

//单潜客成本及潜客转化率统计
function averagePassengerFlowChange() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthpassengerflowchange',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var hobbyList = new Array(); //爱好类活动成本列表
            var partyList = new Array(); //派对类活动成本列表
            var jobList = new Array(); //职业类活动成本列表

            var hobbyRateList = new Array(); //爱好类潜客转化率列表
            var partyRateList = new Array(); //派对类潜客转化率列表
            var jobRateList = new Array(); //职业类潜客转化率列表

            var averageCostList = new Array(); //活动潜客成本列表
            var averageRateList = new Array(); //活动潜客转化率列表

            for (var i = 0; i < data.allaveragelist.length; i++) {
                str += '<span>' + data.allaveragelist[i].nmonth + '月</span>';
                monthList[i] = data.allaveragelist[i].nmonth + '月';
                averageCostList.push(data.allaveragelist[i].LatentPassengerFlowcost);
                averageRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            var summaryList = data.allaveragelist;

            for (var i = 0; i < data.averagelist.length; i++) {
                if (data.averagelist[i].saleactivitytypeid == 2) {
                    hobbyList.push(data.averagelist[i].LatentPassengerFlowcost);
                    hobbyRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
                if (data.averagelist[i].saleactivitytypeid == 1) {
                    partyList.push(data.averagelist[i].LatentPassengerFlowcost);
                    partyRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
                if (data.averagelist[i].saleactivitytypeid == 3) {
                    jobList.push(data.averagelist[i].LatentPassengerFlowcost);
                    jobRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
            }

            $('.summary-cost em').html(summaryList[0].LatentPassengerFlowcost);
            $('.summary-rate em').html(summaryList[0].rate);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-cost em').html(summaryList[i].LatentPassengerFlowcost);
                        $('.summary-rate em').html(summaryList[i].rate);
                    }
                }
            })

            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                grid: {
                    bottom: 90
                },
                legend: [{
                    x: 'center',
                    bottom: 25,
                    data: ['爱好类活动潜客成本', '派对类活动潜客成本', '职业类活动潜客成本', '当月活动潜客成本']
                }, {
                    x: 'center',
                    bottom: 0,
                    data: ['爱好类活动潜客转化率', '派对类活动潜客转化率', '职业类活动潜客转化率', '当月活动潜客转化率']
                }],
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: '潜客成本',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }, {
                    type: 'value',
                    name: '潜客转化率',
                    axisLabel: {
                        formatter: '{value}%'
                    }
                }],
                series: [{
                    name: '爱好类活动潜客成本',
                    type: 'line',
                    data: hobbyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动潜客成本',
                    type: 'line',
                    data: partyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动潜客成本',
                    type: 'line',
                    data: jobList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '当月活动潜客成本',
                    type: 'line',
                    data: averageCostList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '爱好类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: hobbyRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: partyRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: jobRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '当月活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: averageRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }]
            })
        }
    });
}

//订单潜客成本及潜客转化率
function averageOrderCost() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/getevertymonthordercostlist',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var hobbyList = new Array(); //爱好类活动成本列表
            var partyList = new Array(); //派对类活动成本列表
            var jobList = new Array(); //职业类活动成本列表

            var hobbyRateList = new Array(); //爱好类潜客转化率列表
            var partyRateList = new Array(); //派对类潜客转化率列表
            var jobRateList = new Array(); //职业类潜客转化率列表

            var averageCostList = new Array(); //活动潜客成本列表
            var averageRateList = new Array(); //活动潜客转化率列表

            for (var i = 0; i < data.allaveragelist.length; i++) {
                str += '<span>' + data.allaveragelist[i].nmonth + '月</span>';
                monthList[i] = data.allaveragelist[i].nmonth + '月';
                averageCostList.push(data.allaveragelist[i].ordercost);
                averageRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            var summaryList = data.allaveragelist;

            for (var i = 0; i < data.averagelist.length; i++) {
                if (data.averagelist[i].saleactivitytypeid == 2) {
                    hobbyList.push(data.averagelist[i].ordercost);
                    hobbyRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
                if (data.averagelist[i].saleactivitytypeid == 1) {
                    partyList.push(data.averagelist[i].ordercost);
                    partyRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
                if (data.averagelist[i].saleactivitytypeid == 3) {
                    jobList.push(data.averagelist[i].ordercost);
                    jobRateList.push(data.averagelist[i].rate.substr(0, data.averagelist[i].rate.length - 1));
                }
            }

            $('.summary-cost em').html(summaryList[0].ordercost);
            $('.summary-rate em').html(summaryList[0].rate);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-cost em').html(summaryList[i].ordercost);
                        $('.summary-rate em').html(summaryList[i].rate);
                    }
                }
            })

            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                grid: {
                    bottom: 90
                },
                legend: [{
                    x: 'center',
                    bottom: 25,
                    data: ['爱好类活动潜客成本', '派对类活动潜客成本', '职业类活动潜客成本', '当月活动潜客成本']
                }, {
                    x: 'center',
                    bottom: 0,
                    data: ['爱好类活动潜客转化率', '派对类活动潜客转化率', '职业类活动潜客转化率', '当月活动潜客转化率']
                }],
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: '潜客成本',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }, {
                    type: 'value',
                    name: '潜客转化率',
                    axisLabel: {
                        formatter: '{value}%'
                    }
                }],
                series: [{
                    name: '爱好类活动潜客成本',
                    type: 'line',
                    data: hobbyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动潜客成本',
                    type: 'line',
                    data: partyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动潜客成本',
                    type: 'line',
                    data: jobList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '当月活动潜客成本',
                    type: 'line',
                    data: averageCostList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '爱好类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: hobbyRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: partyRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: jobRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '当月活动潜客转化率',
                    type: 'line',
                    yAxisIndex: 1,
                    data: averageRateList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }]
            })
        }
    });
}

//全国经销商车主俱乐部概况统计
function club() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthaveragepassengerflow',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var hobbyList = new Array(); //爱好类客流列表
            var partyList = new Array(); //派对类客流列表
            var jobList = new Array(); //职业类客流列表

            for (var i = 0; i < data.alltotallist.length; i++) {
                str += '<span data-id="' + data.alltotallist[i].nmonth + '">' + data.alltotallist[i].nmonth + '月</span>';
                monthList[i] = data.alltotallist[i].nmonth + '月';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            var summaryList = data.alltotallist; //每月活动场均客流

            for (var i = 0; i < data.averagebytypelist.length; i++) {
                if (data.averagebytypelist[i].saleactivitytypeid == 2) {
                    hobbyList.push(data.averagebytypelist[i].average);
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 1) {
                    partyList.push(data.averagebytypelist[i].average);
                }
                if (data.averagebytypelist[i].saleactivitytypeid == 3) {
                    jobList.push(data.averagebytypelist[i].average);
                }

                for (var j = 0; j < summaryList.length; j++) {
                    if (summaryList[j].nmonth == data.averagebytypelist[i].month) {
                        switch (data.averagebytypelist[i].saleactivitytypeid) {
                            case 2:
                                summaryList[j].hobby = data.averagebytypelist[i].totalpassengerflow;
                                break;
                            case 1:
                                summaryList[j].party = data.averagebytypelist[i].totalpassengerflow;
                                break;
                            case 3:
                                summaryList[j].job = data.averagebytypelist[i].totalpassengerflow;
                                break;
                        }
                    }
                }
            }

            $('.summary-hobby em').html(summaryList[0].hobby);
            $('.summary-party em').html(summaryList[0].party);
            $('.summary-job em').html(summaryList[0].job);
            $('.summary-average em').html(summaryList[0].totalpassengerflow);

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-hobby em').html(summaryList[i].hobby);
                        $('.summary-party em').html(summaryList[i].party);
                        $('.summary-job em').html(summaryList[i].job);
                        $('.summary-average em').html(summaryList[i].totalpassengerflow);
                    }
                }
            })

            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['爱好类活动场均客流', '派对类活动场均客流', '职业类活动场均客流']
                },
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: '人次',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }],
                series: [{
                    name: '爱好类活动场均客流',
                    type: 'bar',
                    data: hobbyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '派对类活动场均客流',
                    type: 'bar',
                    data: partyList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '职业类活动场均客流',
                    type: 'bar',
                    data: jobList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }]
            })
        }
    });
}

//车主俱乐部活动场次
function clubInfo() {
    myChart = echarts.init(document.getElementById('main'));
    myChart.showLoading();
    $.ajax({
        type: "post",
        url: ajax_url + '/api/apiactivitychart/geteverymonthclubactivitybuildecount',
        success: function (data) {
            myChart.hideLoading();

            var monthList = new Array(); //举办了活动的月份列表
            var str = '';

            var driveList = new Array(); //自驾游场次列表
            var courseList = new Array(); //讲堂场次列表
            var otherList = new Array(); //其他类场次列表

            var summaryList = new Array(); //每月活动场次

            for (var i = 0; i < data.averagelist.length; i++) {
                var month = data.averagelist[i].nmonth + '月';
                if (monthList.indexOf(month) == -1) {
                    monthList.push(month);
                    summaryList.push({
                        nmonth: month.substr(0, month.length - 1),
                        drive: 0,
                        course: 0,
                        other: 0
                    });
                }
            }
            
            //设置数组默认值, 占满x轴长度
            for (var i = 0; i < monthList.length; i++) {
                driveList.push(0);
                courseList.push(0);
                otherList.push(0);

                str += '<span>' + monthList[i] + '</span>';
            }
            $('.select-option').html(str);
            $('.select-show').html(monthList[0]);

            for (var i = 0; i < data.averagelist.length; i++) {
                if (data.averagelist[i].clubactivitytypeid == 3) {
                    var index = monthList.indexOf(data.averagelist[i].nmonth + '月');
                    driveList[index] = data.averagelist[i].count;
                }
                if (data.averagelist[i].clubactivitytypeid == 4) {
                    var index = monthList.indexOf(data.averagelist[i].nmonth + '月');
                    courseList[index] = data.averagelist[i].count;
                }
                if (data.averagelist[i].clubactivitytypeid == 5) {
                    var index = monthList.indexOf(data.averagelist[i].nmonth + '月');
                    otherList[index] = data.averagelist[i].count;
                }                

                for (var j = 0; j < summaryList.length; j++) {
                    if (summaryList[j].nmonth == data.averagelist[i].nmonth) {
                        switch (data.averagelist[i].clubactivitytypeid) {
                            case 3:
                                summaryList[j].drive = data.averagelist[i].count;
                                break;
                            case 4:
                                summaryList[j].course = data.averagelist[i].count;
                                break;
                            case 5:
                                summaryList[j].other = data.averagelist[i].count;
                                break;
                        }
                    }
                }
            }
            
            for (var i = 0; i < summaryList.length; i++) {
                summaryList[i].total = summaryList[i].drive + summaryList[i].course + summaryList[i].other;
            }

            //月份筛选
            $('.select-option').on('click', 'span', function () {
                var selected_month = $(this).html();
                var index = monthList.indexOf(selected_month);
                selected_month = selected_month.substr(0, selected_month.length - 1);
                for (var i = 0; i < summaryList.length; i++) {
                    if (selected_month == summaryList[i].nmonth) {
                        $('.summary-drive em').html(summaryList[i].drive);
                        $('.summary-course em').html(summaryList[i].course);
                        $('.summary-other em').html(summaryList[i].other);
                        $('.summary-total em').html(summaryList[i].total);
                    }
                }
            })

            myChart.setOption({
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: ['自驾游活动场次', '讲堂类活动场次', '其他类活动场次']
                },
                xAxis: [{
                    type: 'category',
                    data: monthList,
                    axisPointer: {
                        type: 'shadow'
                    }
                }],
                yAxis: [{
                    type: 'value',
                    name: '场次',
                    axisLabel: {
                        formatter: '{value}'
                    }
                }],
                series: [{
                    name: '自驾游活动场次',
                    type: 'bar',
                    data: driveList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '讲堂类活动场次',
                    type: 'bar',
                    data: courseList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }, {
                    name: '其他类活动场次',
                    type: 'bar',
                    data: otherList,
                    itemStyle: {
                        normal: {
                            label: { show: true, position: 'top' }
                        }
                    }
                }]
            })
        }
    });
}
