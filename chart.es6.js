class BaseChart {
  constructor(datasource, attrs){
     this.datasource = datasource;
     this.attrs = attrs;
  }
}
class MyLineChart extends BaseChart{
  init(){
    var data = new google.visualization.DataTable();
    data.addColumn('date', 'date');
    data.addColumn('number', this.attrs.columnName);
    data.addRows(this.datasource);
    var formatter = new google.visualization.DateFormat({pattern: 'MM/dd/yyyy'});
    formatter.format(data, 0);

    var options = {
      title: this.attrs.title,
      legend: { position: 'top', alignment: 'center' },
      hAxis: { 
        format: "MM/dd/yyyy",
        ticks: this.datasource.map(function(item){
           return item[0];
        }),
        gridlines: { color: "#fff" }
      },
      width: 900,
      height: 400,
      pointSize: 5
    };
    // Classic Line
    var chart = new google.visualization.LineChart(this.attrs.container);
    chart.draw(data, google.charts.Line.convertOptions(options));
  }
  render(){
    google.charts.load('current', {packages: ['corechart', 'line']});
    google.charts.setOnLoadCallback(this.init.bind(this));          
  }
}
window.MyChart = {
    RenderLineChart : function(datasource, attrs){
      new MyLineChart(datasource, attrs).render();
    }
}
