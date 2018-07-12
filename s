[33mcommit e1f3035b54b66d5053e13f77e94d883c5ba1e1fe[m
Author: Dao Nguyen <spaceman27@gmail.com>
Date:   Wed Oct 5 01:25:30 2016 -0700

    Backbone SPA and google chart
    
    Backbone SPA Route/Model/View
    ES6 syntax
    prototype to consume google chart api

[1mdiff --git a/README.md b/README.md[m
[1mnew file mode 100644[m
[1mindex 0000000..e69de29[m
[1mdiff --git a/chart.es6.js b/chart.es6.js[m
[1mnew file mode 100644[m
[1mindex 0000000..3a98779[m
[1m--- /dev/null[m
[1m+++ b/chart.es6.js[m
[36m@@ -0,0 +1,43 @@[m
[32m+[m[32mclass BaseChart {[m
[32m+[m[32m  constructor(datasource, attrs){[m
[32m+[m[32m     this.datasource = datasource;[m
[32m+[m[32m     this.attrs = attrs;[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m[32mclass MyLineChart extends BaseChart{[m
[32m+[m[32m  init(){[m
[32m+[m[32m    var data = new google.visualization.DataTable();[m
[32m+[m[32m    data.addColumn('date', 'date');[m
[32m+[m[32m    data.addColumn('number', this.attrs.columnName);[m
[32m+[m[32m    data.addRows(this.datasource);[m
[32m+[m[32m    var formatter = new google.visualization.DateFormat({pattern: 'MM/dd/yyyy'});[m
[32m+[m[32m    formatter.format(data, 0);[m
[32m+[m
[32m+[m[32m    var options = {[m
[32m+[m[32m      title: this.attrs.title,[m
[32m+[m[32m      legend: { position: 'top', alignment: 'center' },[m
[32m+[m[32m      hAxis: {[m[41m [m
[32m+[m[32m        format: "MM/dd/yyyy",[m
[32m+[m[32m        ticks: this.datasource.map(function(item){[m
[32m+[m[32m           return item[0];[m
[32m+[m[32m        }),[m
[32m+[m[32m        gridlines: { color: "#fff" }[m
[32m+[m[32m      },[m
[32m+[m[32m      width: 900,[m
[32m+[m[32m      height: 400,[m
[32m+[m[32m      pointSize: 5[m
[32m+[m[32m    };[m
[32m+[m[32m    // Classic Line[m
[32m+[m[32m    var chart = new google.visualization.LineChart(this.attrs.container);[m
[32m+[m[32m    chart.draw(data, google.charts.Line.convertOptions(options));[m
[32m+[m[32m  }[m
[32m+[m[32m  render(){[m
[32m+[m[32m    google.charts.load('current', {packages: ['corechart', 'line']});[m
[32m+[m[32m    google.charts.setOnLoadCallback(this.init.bind(this));[m[41m          [m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m[32mwindow.MyChart = {[m
[32m+[m[32m    RenderLineChart : function(datasource, attrs){[m
[32m+[m[32m      new MyLineChart(datasource, attrs).render();[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/index.html b/index.html[m
[1mnew file mode 100644[m
[1mindex 0000000..44863bf[m
[1m--- /dev/null[m
[1m+++ b/index.html[m
[36m@@ -0,0 +1,26 @@[m
[32m+[m[32m<!DOCTYPE html>[m
[32m+[m[32m<html>[m
[32m+[m
[32m+[m[32m  <head>[m
[32m+[m[32m    <link data-require="jasmine@*" data-semver="2.4.1" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.css" />[m
[32m+[m[32m    <link rel="stylesheet" href="style.css" />[m
[32m+[m[41m   [m
[32m+[m[32m  </head>[m
[32m+[m
[32m+[m[32m  <body>[m
[32m+[m[32m    <select class="select-chart-stat"></select>[m
[32m+[m[32m    <div id="linechart_material"></div>[m
[32m+[m[32m    <script type="text/template" class="chart-select-template"><%= get("title") %></script>[m
[32m+[m[32m    <script data-require="jasmine@*" data-semver="2.4.1" src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.js"></script>[m
[32m+[m[32m    <script data-require="jasmine@*" data-semver="2.4.1" src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine-html.js"></script>[m
[32m+[m[32m    <script data-require="jasmine@*" data-semver="2.4.1" src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/boot.js"></script>[m
[32m+[m[32m    <script data-require="jquery@*" data-semver="3.0.0" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.js"></script>[m
[32m+[m[32m    <script data-require="underscore.js@*" data-semver="1.8.3" src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>[m
[32m+[m[32m    <script data-require="backbone.js@*" data-semver="1.1.2" src="    //cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min.js"></script>[m
[32m+[m[32m    <script data-require="moment.js@2.14.1" data-semver="2.14.1" src="https://npmcdn.com/moment@2.14.1"></script>[m
[32m+[m[32m    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>[m
[32m+[m[32m    <script src="chart.js"></script>[m
[32m+[m[32m    <script src="script.js"></script>[m
[32m+[m[32m    <script src="testing.js"></script>[m
[32m+[m[32m  </body>[m
[32m+[m[32m</html>[m
[1mdiff --git a/report.json b/report.json[m
[1mnew file mode 100644[m
[1mindex 0000000..9d65929[m
[1m--- /dev/null[m
[1m+++ b/report.json[m
[36m@@ -0,0 +1,222 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "xaxis": "date",[m
[32m+[m[32m  "records": [[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "04/27/2016",[m
[32m+[m[32m      "clickThruRate": 11.575086019490813,[m
[32m+[m[32m      "sales": 1685103.46,[m
[32m+[m[32m      "pageViews": 672522,[m
[32m+[m[32m      "orders": 14274[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "04/28/2016",[m
[32m+[m[32m      "clickThruRate": 11.057877730829555,[m
[32m+[m[32m      "sales": 1409394.37,[m
[32m+[m[32m      "pageViews": 700062,[m
[32m+[m[32m      "orders": 13279[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "04/29/2016",[m
[32m+[m[32m      "clickThruRate": 10.769637784623608,[m
[32m+[m[32m      "sales": 1587128.08,[m
[32m+[m[32m      "pageViews": 733293,[m
[32m+[m[32m      "orders": 15378[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "04/30/2016",[m
[32m+[m[32m      "clickThruRate": 11.793559308371288,[m
[32m+[m[32m      "sales": 2021584.7,[m
[32m+[m[32m      "pageViews": 744330,[m
[32m+[m[32m      "orders": 16934[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/01/2016",[m
[32m+[m[32m      "clickThruRate": 11.906171613821066,[m
[32m+[m[32m      "sales": 1916290.7,[m
[32m+[m[32m      "pageViews": 721189,[m
[32m+[m[32m      "orders": 16156[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/02/2016",[m
[32m+[m[32m      "clickThruRate": 11.618584711166937,[m
[32m+[m[32m      "sales": 1903934.82,[m
[32m+[m[32m      "pageViews": 732430,[m
[32m+[m[32m      "orders": 16097[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/03/2016",[m
[32m+[m[32m      "clickThruRate": 11.816696070335519,[m
[32m+[m[32m      "sales": 1829264.87,[m
[32m+[m[32m      "pageViews": 754441,[m
[32m+[m[32m      "orders": 15928[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/04/2016",[m
[32m+[m[32m      "clickThruRate": 11.348390339421794,[m
[32m+[m[32m      "sales": 1801206.07,[m
[32m+[m[32m      "pageViews": 688406,[m
[32m+[m[32m      "orders": 14728[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/05/2016",[m
[32m+[m[32m      "clickThruRate": 10.878498398534205,[m
[32m+[m[32m      "sales": 1469729.23,[m
[32m+[m[32m      "pageViews": 714970,[m
[32m+[m[32m      "orders": 13465[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/06/2016",[m
[32m+[m[32m      "clickThruRate": 10.516210900323584,[m
[32m+[m[32m      "sales": 1718445.58,[m
[32m+[m[32m      "pageViews": 788050,[m
[32m+[m[32m      "orders": 15098[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/07/2016",[m
[32m+[m[32m      "clickThruRate": 11.526655322695047,[m
[32m+[m[32m      "sales": 2114943.18,[m
[32m+[m[32m      "pageViews": 830397,[m
[32m+[m[32m      "orders": 17652[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "date": "05/08/2016",[m
[32m+[m[32m      "clickThruRate": 11