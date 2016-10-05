// routing 
var WorkSpace = Backbone.Router.extend({
  routes: {
    "dashboard/index": "index"
  },
  index: function(query) {
    console.log("navigating to dashboard/index page");
    $(document).ready(function() {
      var selectView = new SelectList();
    });
  }
})
var router = new WorkSpace();
Backbone.history.start();
router.navigate("dashboard/index", {  trigger: true  })

  // API Call
var Api = Backbone.Model.extend({  url: "report.json" })

function getApi() {
  var result = $.Deferred();
  var api = new Api().fetch({
    success: function(rs) {
      console.log("fetch report.json succeeded");
      result.resolve(rs);
    },
    fail: function() {
      console.log("fetch report.json failed");
      result.reject()
    }
  })
  return result;
}

var Stat = Backbone.Model.extend({title: "", value: ""})

function getSourceByType(type) {
  var result = $.Deferred();
  getApi().then(function(rs) {
    result.resolve(rs.get("records").map(function(el) {
      var dateFormat = moment(el.date, "MM-DD-YYYY");
      return [new Date(dateFormat.year(), dateFormat.month(), dateFormat.date()), el[type]];
    }));
  })
  return result;
}
var salesStat = new Stat({  title: "overall sales",  value: "sales"})
var ordersStat = new Stat({  title: "overall orders",  value: "orders"})
var pageViewStat = new Stat({  title: "page view",  value: "pageViews"})
var clickThruRateStat = new Stat({  title: "page rec clickthru rate",  value: "clickThruRate"})

var Stats = Backbone.Collection.extend({});
var stats = new Stats([salesStat, ordersStat, pageViewStat, clickThruRateStat]);
var OptionList = Backbone.View.extend({
  tagName: "option",
  render: function() {
    this.$el.html(_.template($('.chart-select-template').html())(this.model));
    return this;
  }
});
var MyLineChartView = Backbone.View.extend({
  initialize: function () { 
    this.listenTo(this.model, 'change', this.render);
  },
  render: function() {
    var model = this.model;
    getSourceByType(this.model.get("value")).then(function(rs) {
      window.MyChart.RenderLineChart(rs, {
        title: model.get("title"),
        columnName: model.get("value"),
        container: document.getElementById('linechart_material')
      });
    })
  }
});
var lineChartView;
SelectList = Backbone.View.extend({
  el: $(".select-chart-stat"),
  events: {
    "change": "changeSelectedStat"
  },
  render: function() {
    var self = this;
    this.$el.html('');
    _(stats.models).each(function(stat) {
      self.$el.append(new OptionList({
        model: stat
      }).render().$el);
    });
    lineChartView = new MyLineChartView({model: stats.models[0]});
    lineChartView.render()
    return this;
  },
  changeSelectedStat: function(e) {
    lineChartView.model.set(stats.models[e.target.selectedIndex].toJSON())
  }
});
